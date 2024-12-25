import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'musicfy_method_channel.dart';

abstract class MusicfyPlatform extends PlatformInterface {
  /// سازنده کلاس انتزاعی
  MusicfyPlatform() : super(token: _token);

  static final Object _token = Object();

  /// نمونه پیش‌فرض از کلاس
  static MusicfyPlatform _instance = MethodChannelMusicfy();

  /// دریافت نمونه
  static MusicfyPlatform get instance => _instance;

  /// تنظیم نمونه
  static set instance(MusicfyPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// متد انتزاعی برای دریافت نسخه پلتفرم
  Future<String?> getPlatformVersion() {
    throw UnimplementedError('getPlatformVersion() has not been implemented.');
  }

  /// متد انتزاعی برای دریافت لیست موزیک
  Future<List<dynamic>> getMusicList() {
    throw UnimplementedError('getMusicList() has not been implemented.');
  }
}
