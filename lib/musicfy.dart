import 'musicfy_platform_interface.dart';

class Musicfy {
  /// متدی برای دریافت نسخه پلتفرم
  Future<String?> getPlatformVersion() {
    return MusicfyPlatform.instance.getPlatformVersion();
  }

  /// متدی برای دریافت لیست موزیک
  Future<List<dynamic>> getMusicList() {
    return MusicfyPlatform.instance.getMusicList();
  }
}
