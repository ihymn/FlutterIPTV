import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'service_locator.dart';

/// 日志级别
enum LogLevel {
  debug,    // 调试模式：记录所有日志
  release,  // 发布模式：只记录警告和错误
  off,      // 关闭日志
}

/// 日志服务 - 统一管理应用日志
class LogService {
  static final LogService _instance = LogService._internal();
  factory LogService() => _instance;
  LogService._internal();

  Logger? _logger;
  LogLevel _currentLevel = LogLevel.release;
  String? _logFilePath;
  bool _initialized = false;

  /// 初始化日志服务
  Future<void> init({SharedPreferences? prefs}) async {
    if (_initialized) return;

    try {
      // 从设置中读取日志级别
      final preferences = prefs ?? ServiceLocator.prefs;
      final levelString = preferences.getString('log_level') ?? 'off';
      _currentLevel = _parseLogLevel(levelString);

      if (_currentLevel == LogLevel.off) {
        debugPrint('LogService: 日志已关闭');
        _initialized = true;
        return;
      }

      // 获取日志文件路径
      _logFilePath = await _getLogFilePath();
      
      if (_logFilePath != null) {
        // 创建日志目录
        final logDir = Directory(path.dirname(_logFilePath!));
        if (!await logDir.exists()) {
          await logDir.create(recursive: true);
        }

        // 清理旧日志（保留最近7天）
        await _cleanOldLogs(logDir);

        // 创建 Logger 实例
        _logger = Logger(
          filter: _LogFilter(_currentLevel),
          printer: _LogPrinter(),
          output: _FileOutput(_logFilePath!),
          level: _currentLevel == LogLevel.debug ? Level.debug : Level.warning,
        );

        debugPrint('LogService: 初始化成功，日志文件: $_logFilePath');
        debugPrint('LogService: 日志级别: ${_currentLevel.name}');
        
        // 写入启动日志
        _logger?.i('========================================');
        _logger?.i('应用启动 - ${DateTime.now()}');
        _logger?.i('日志级别: ${_currentLevel.name}');
        _logger?.i('========================================');
      }

      _initialized = true;
    } catch (e) {
      debugPrint('LogService: 初始化失败 - $e');
    }
  }

  /// 获取日志文件路径
  Future<String?> _getLogFilePath() async {
    try {
      Directory? logDir;

      if (Platform.isWindows) {
        // Windows: 使用应用安装目录下的 logs 文件夹
        final exePath = Platform.resolvedExecutable;
        final exeDir = path.dirname(exePath);
        logDir = Directory(path.join(exeDir, 'logs'));
      } else if (Platform.isAndroid) {
        // Android: 使用应用的外部存储目录
        final appDir = await getExternalStorageDirectory();
        if (appDir != null) {
          logDir = Directory(path.join(appDir.path, 'logs'));
        }
      } else {
        // 其他平台：使用应用文档目录
        final appDir = await getApplicationDocumentsDirectory();
        logDir = Directory(path.join(appDir.path, 'logs'));
      }

      if (logDir == null) return null;

      // 创建日志目录
      if (!await logDir.exists()) {
        await logDir.create(recursive: true);
      }

      // 日志文件名：lotus_iptv_YYYYMMDD.log
      final dateStr = DateFormat('yyyyMMdd').format(DateTime.now());
      return path.join(logDir.path, 'lotus_iptv_$dateStr.log');
    } catch (e) {
      debugPrint('LogService: 获取日志路径失败 - $e');
      return null;
    }
  }

  /// 清理旧日志（保留最近7天）
  Future<void> _cleanOldLogs(Directory logDir) async {
    try {
      final now = DateTime.now();
      final files = await logDir.list().toList();

      for (final file in files) {
        if (file is File && file.path.endsWith('.log')) {
          final stat = await file.stat();
          final age = now.difference(stat.modified).inDays;
          
          if (age > 7) {
            await file.delete();
            debugPrint('LogService: 删除旧日志 - ${path.basename(file.path)}');
          }
        }
      }
    } catch (e) {
      debugPrint('LogService: 清理旧日志失败 - $e');
    }
  }

  /// 解析日志级别
  LogLevel _parseLogLevel(String level) {
    switch (level.toLowerCase()) {
      case 'debug':
        return LogLevel.debug;
      case 'release':
        return LogLevel.release;
      case 'off':
        return LogLevel.off;
      default:
        return LogLevel.release;
    }
  }

  /// 设置日志级别
  Future<void> setLogLevel(LogLevel level) async {
    _currentLevel = level;
    
    // 保存到设置
    try {
      final prefs = ServiceLocator.prefs;
      await prefs.setString('log_level', level.name);
    } catch (e) {
      debugPrint('LogService: 保存日志级别失败 - $e');
    }

    // 重新初始化
    _initialized = false;
    _logger = null;
    await init();
  }

  /// 获取当前日志级别
  LogLevel get currentLevel => _currentLevel;

  /// 获取日志文件路径
  String? get logFilePath => _logFilePath;

  /// Debug 日志
  void d(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    if (_currentLevel == LogLevel.off) return;
    final msg = tag != null ? '[$tag] $message' : message;
    _logger?.d(msg, error: error, stackTrace: stackTrace);
    if (kDebugMode) debugPrint('DEBUG: $msg');
  }

  /// Info 日志
  void i(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    if (_currentLevel == LogLevel.off) return;
    final msg = tag != null ? '[$tag] $message' : message;
    _logger?.i(msg, error: error, stackTrace: stackTrace);
    if (kDebugMode) debugPrint('INFO: $msg');
  }

  /// Warning 日志
  void w(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    if (_currentLevel == LogLevel.off) return;
    final msg = tag != null ? '[$tag] $message' : message;
    _logger?.w(msg, error: error, stackTrace: stackTrace);
    if (kDebugMode) debugPrint('WARN: $msg');
  }

  /// Error 日志
  void e(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    if (_currentLevel == LogLevel.off) return;
    final msg = tag != null ? '[$tag] $message' : message;
    _logger?.e(msg, error: error, stackTrace: stackTrace);
    if (kDebugMode) debugPrint('ERROR: $msg');
  }

  /// 获取日志目录
  Future<Directory?> getLogDirectory() async {
    if (_logFilePath == null) return null;
    return Directory(path.dirname(_logFilePath!));
  }

  /// 获取所有日志文件
  Future<List<File>> getLogFiles() async {
    final logDir = await getLogDirectory();
    if (logDir == null || !await logDir.exists()) return [];

    final files = await logDir.list().toList();
    return files
        .whereType<File>()
        .where((f) => f.path.endsWith('.log'))
        .toList()
      ..sort((a, b) => b.path.compareTo(a.path)); // 按日期倒序
  }

  /// 导出日志文件（用于分享给开发者）
  Future<String?> exportLogs() async {
    try {
      final logFiles = await getLogFiles();
      if (logFiles.isEmpty) return null;

      // 合并所有日志文件
      final buffer = StringBuffer();
      buffer.writeln('========================================');
      buffer.writeln('Lotus IPTV 日志导出');
      buffer.writeln('导出时间: ${DateTime.now()}');
      buffer.writeln('========================================\n');

      for (final file in logFiles) {
        buffer.writeln('\n========== ${path.basename(file.path)} ==========\n');
        final content = await file.readAsString();
        buffer.writeln(content);
      }

      // 保存到临时文件
      final tempDir = await getTemporaryDirectory();
      final exportFile = File(path.join(
        tempDir.path,
        'lotus_iptv_logs_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.txt',
      ));
      await exportFile.writeAsString(buffer.toString());

      return exportFile.path;
    } catch (e) {
      debugPrint('LogService: 导出日志失败 - $e');
      return null;
    }
  }

  /// 清空所有日志
  Future<void> clearLogs() async {
    try {
      final logDir = await getLogDirectory();
      if (logDir == null || !await logDir.exists()) return;

      final files = await logDir.list().toList();
      for (final file in files) {
        if (file is File && file.path.endsWith('.log')) {
          await file.delete();
        }
      }

      debugPrint('LogService: 已清空所有日志');
      
      // 重新初始化以创建新日志文件
      _initialized = false;
      await init();
    } catch (e) {
      debugPrint('LogService: 清空日志失败 - $e');
    }
  }
}

/// 自定义日志过滤器
class _LogFilter extends LogFilter {
  final LogLevel logLevel;

  _LogFilter(this.logLevel);

  @override
  bool shouldLog(LogEvent event) {
    if (logLevel == LogLevel.off) return false;
    if (logLevel == LogLevel.debug) return true;
    // Release 模式只记录 warning 和 error
    return event.level.index >= Level.warning.index;
  }
}

/// 自定义日志打印器
class _LogPrinter extends LogPrinter {
  static final _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');

  @override
  List<String> log(LogEvent event) {
    final time = _dateFormat.format(event.time);
    final level = event.level.name.toUpperCase().padRight(7);
    final message = event.message;
    
    final buffer = StringBuffer();
    buffer.write('$time [$level] $message');

    if (event.error != null) {
      buffer.write('\nError: ${event.error}');
    }

    if (event.stackTrace != null) {
      buffer.write('\nStackTrace:\n${event.stackTrace}');
    }

    return [buffer.toString()];
  }
}

/// 文件输出
class _FileOutput extends LogOutput {
  final String filePath;
  File? _file;

  _FileOutput(this.filePath);

  @override
  Future<void> init() async {
    _file = File(filePath);
  }

  @override
  void output(OutputEvent event) {
    if (_file == null) return;

    try {
      final buffer = StringBuffer();
      for (final line in event.lines) {
        buffer.writeln(line);
      }
      
      // 追加写入文件
      _file!.writeAsStringSync(
        buffer.toString(),
        mode: FileMode.append,
        flush: true,
      );
    } catch (e) {
      debugPrint('LogService: 写入日志失败 - $e');
    }
  }
}
