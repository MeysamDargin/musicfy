# musicfy

A Flutter plugin for accessing music files on Android and iOS devices, allowing you to retrieve music metadata such as title, artist, album, and album artwork.

## Features

- Retrieve a list of music files from the device's media library.
- Get metadata for each track: title, artist, album, and path.
- Permission handling to request access to the media library.

## Getting Started

This project is a Flutter plugin that provides a simple interface for accessing music metadata on Android and iOS devices.

### Installation

To use `musicfy` in your Flutter project, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  musicfy: ^1.0.0
```

Then run:

```bash
flutter pub get
```

### Platform Setup

#### Android

1. Open the `AndroidManifest.xml` file and add the required permissions to access the media library:

   ```xml
   <uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />
   <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
   <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
   ```

2. Make sure to handle runtime permissions in your application using the `permission_handler` package.

#### iOS

Support for iOS is coming soon. Please ensure you add the necessary permission to the `Info.plist`:

```xml
<key>NSAppleMusicUsageDescription</key>
<string>We need access to your music library</string>
```

This feature is not yet fully supported, but will be available in an upcoming release.

### Usage

Here’s how you can use the `musicfy` plugin in your Flutter application:

1. Import the `musicfy` package:

   ```dart
   import 'package:musicfy/musicfy.dart';
   import 'package:permission_handler/permission_handler.dart';
   ```

2. Request the necessary permissions to access the media library:

   ```dart
   PermissionStatus status = await Permission.audio.request();
   if (status.isGranted) {
     final musicList = await Musicfy().getMusicList();
     // Handle music list
   } else {
     // Handle permission denial
   }
   ```

3. Display the retrieved music list:

   ```dart
   ListView.builder(
     itemCount: musicList.length,
     itemBuilder: (context, index) {
       final music = musicList[index];
       return ListTile(
         title: Text(music['title']),
         subtitle: Text('${music['artist']} - ${music['album']}'),
         leading: Icon(Icons.music_note),
       );
     },
   );
   ```

### API

#### `getMusicList()`

- **Returns**: A list of maps, each containing the following keys:
  - `title`: The title of the track.
  - `artist`: The artist of the track.
  - `album`: The album name of the track.
  - `path`: The file path to the track on the device.

#### Permissions

This plugin requires the following permissions:

- **Android**: `READ_EXTERNAL_STORAGE` and `READ_MEDIA_AUDIO`
- **iOS**: `NSAppleMusicUsageDescription` (for future iOS support)

Make sure to request permissions at runtime using the `permission_handler` package.

## Contributing

We welcome contributions to the `musicfy` plugin! Please follow the steps below to contribute:

1. Fork the repository.
2. Create a new branch.
3. Make your changes.
4. Run tests to make sure everything works.
5. Submit a pull request.

## Author

This project is maintained by **Meysam Alizadeh**.
email: **m10551691@gmail.com**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


