import 'color_scheme_data.dart';

/// 配色方案管理器
/// 单例模式，管理所有可用的配色方案
class ColorSchemeManager {
  // 单例实例
  static final ColorSchemeManager instance = ColorSchemeManager._();
  
  ColorSchemeManager._();
  
  // ============ 黑暗模式配色方案列表 ============
  static const List<ColorSchemeData> darkSchemes = [
    darkLotus,
    darkOcean,
    darkForest,
    darkSunset,
    darkLavender,
    darkMidnight,
  ];
  
  // ============ 明亮模式配色方案列表 ============
  static const List<ColorSchemeData> lightSchemes = [
    lightLotus,
    lightSky,
    lightSpring,
    lightCoral,
    lightViolet,
    lightClassic,
  ];
  
  /// 根据 ID 获取黑暗模式配色方案
  /// 如果找不到，返回默认的 Lotus 配色
  ColorSchemeData getDarkScheme(String id) {
    try {
      return darkSchemes.firstWhere((scheme) => scheme.id == id);
    } catch (_) {
      // 找不到时返回默认配色
      return darkLotus;
    }
  }
  
  /// 根据 ID 获取明亮模式配色方案
  /// 如果找不到，返回默认的 Lotus Light 配色
  ColorSchemeData getLightScheme(String id) {
    try {
      return lightSchemes.firstWhere((scheme) => scheme.id == id);
    } catch (_) {
      // 找不到时返回默认配色
      return lightLotus;
    }
  }
  
  /// 获取所有黑暗模式配色方案
  List<ColorSchemeData> getAllDarkSchemes() {
    return darkSchemes;
  }
  
  /// 获取所有明亮模式配色方案
  List<ColorSchemeData> getAllLightSchemes() {
    return lightSchemes;
  }
  
  /// 检查配色方案 ID 是否有效（黑暗模式）
  bool isDarkSchemeValid(String id) {
    return darkSchemes.any((scheme) => scheme.id == id);
  }
  
  /// 检查配色方案 ID 是否有效（明亮模式）
  bool isLightSchemeValid(String id) {
    return lightSchemes.any((scheme) => scheme.id == id);
  }
}
