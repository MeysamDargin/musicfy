package com.example.musicfy

import android.content.Context
import android.database.Cursor
import android.provider.MediaStore
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MusicfyPlugin: FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "musicfy")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "getMusicList" -> {
                val musicList = getMusicList()
                result.success(musicList)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun getMusicList(): List<Map<String, String>> {
        val musicList = mutableListOf<Map<String, String>>()
        val projection = arrayOf(
            MediaStore.Audio.Media.TITLE,
            MediaStore.Audio.Media.ARTIST,
            MediaStore.Audio.Media.ALBUM,
            MediaStore.Audio.Media.DATA
        )

        val cursor: Cursor? = context.contentResolver.query(
            MediaStore.Audio.Media.EXTERNAL_CONTENT_URI,
            projection,
            MediaStore.Audio.Media.IS_MUSIC + " != 0",
            null,
            null
        )

        cursor?.use {
            while (it.moveToNext()) {
                val title = it.getString(it.getColumnIndexOrThrow(MediaStore.Audio.Media.TITLE))
                val artist = it.getString(it.getColumnIndexOrThrow(MediaStore.Audio.Media.ARTIST))
                val album = it.getString(it.getColumnIndexOrThrow(MediaStore.Audio.Media.ALBUM))
                val path = it.getString(it.getColumnIndexOrThrow(MediaStore.Audio.Media.DATA))

                val music = mapOf(
                    "title" to title,
                    "artist" to artist,
                    "album" to album,
                    "path" to path
                )
                musicList.add(music)
            }
        }

        return musicList
    }
}
