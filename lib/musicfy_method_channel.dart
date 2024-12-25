import 'package:flutter/services.dart';
import 'musicfy_platform_interface.dart';

/// پیاده‌سازی `MusicfyPlatform` با استفاده از متدهای کانال
class MethodChannelMusicfy extends MusicfyPlatform {
  /// تعریف کانال متدها
  final methodChannel = const MethodChannel('musicfy');

  /// پیاده‌سازی متد دریافت نسخه پلتفرم
  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// پیاده‌سازی متد دریافت لیست موزیک
  @override
  Future<List<dynamic>> getMusicList() async {
    final musicList = await methodChannel.invokeMethod<List<dynamic>>('getMusicList');
    return musicList ?? [];
  }
}
