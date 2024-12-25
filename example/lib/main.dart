import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:musicfy/musicfy.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Musicfy _musicfy = Musicfy();
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<dynamic> _musicList = [];
  String? _currentlyPlaying;

  @override
  void initState() {
    super.initState();
    fetchMusicList();
  }

  @override
  void dispose() {
    // از بین بردن AudioPlayer برای جلوگیری از مصرف منابع
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> fetchMusicList() async {
    // درخواست مجوز دسترسی به رسانه‌ها
    PermissionStatus status = await Permission.audio.request();

    if (status.isGranted) {
      try {
        // اگر مجوز داده شد، لیست موزیک‌ها را دریافت کنید
        final musicList = await _musicfy.getMusicList();
        setState(() {
          _musicList = musicList;
        });
      } catch (e) {
        print('Error fetching music list: $e');
      }
    } else if (status.isPermanentlyDenied) {
      // اگر مجوز به طور دائمی رد شده باشد، کاربر را به تنظیمات هدایت کنید
      print('Permission permanently denied. Redirecting to app settings...');
      openAppSettings();
    } else {
      // اگر مجوز رد شد
      print('Permission denied.');
    }
  }

  Future<void> playMusic(String path) async {
    try {
      await _audioPlayer.setFilePath(path); // تنظیم مسیر فایل برای پخش
      await _audioPlayer.play(); // پخش آهنگ
      setState(() {
        _currentlyPlaying = path;
      });
    } catch (e) {
      print('Error playing music: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Musicfy Plugin Example'),
        ),
        body: _musicList.isEmpty
            ? Center(
                child: Text('No music found or permission denied.'),
              )
            : ListView.builder(
                itemCount: _musicList.length,
                itemBuilder: (context, index) {
                  final music = _musicList[index];
                  final isPlaying = _currentlyPlaying == music['path'];
                  return ListTile(
                    title: Text(music['title']),
                    subtitle: Text('${music['artist']} - ${music['album']}'),
                    trailing: IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
                        color: isPlaying ? Colors.green : Colors.blue,
                      ),
                      onPressed: () {
                        playMusic(music['path']);
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
