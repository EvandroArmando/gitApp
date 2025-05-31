package com.example.git_app

import android.content.Intent
import android.os.Bundle
import android.provider.MediaStore
import android.net.Uri
import java.io.File
import android.os.Environment
import android.media.MediaScannerConnection
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "canal_camera"
    private lateinit var photoUri: Uri
    private var capturedImagePath: String? = null
    private val REQUEST_IMAGE_CAPTURE = 1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "abrirCamera" -> abrirCamera()
                "obterImagemCapturada" -> result.success(capturedImagePath)
                else -> result.notImplemented()
            }
        }
    }

    private fun abrirCamera() {
        val intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)

        val pictureDir = File("/sdcard/Pictures/")
        if (!pictureDir.exists()) {
            pictureDir.mkdirs()
        }

        val photoFile = File(pictureDir, "foto_${System.currentTimeMillis()}.jpg")
        photoUri = FileProvider.getUriForFile(this, "com.example.git_app.fileprovider", photoFile)

        intent.putExtra(MediaStore.EXTRA_OUTPUT, photoUri)
        startActivityForResult(intent, REQUEST_IMAGE_CAPTURE)

        capturedImagePath = photoFile.absolutePath
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == REQUEST_IMAGE_CAPTURE && resultCode == RESULT_OK) {
            capturedImagePath?.let { imagePath ->
                // 🔹 Registra a imagem no sistema
                MediaScannerConnection.scanFile(this, arrayOf(imagePath), arrayOf("image/jpeg"),
                    object : MediaScannerConnection.OnScanCompletedListener {
                        override fun onScanCompleted(path: String?, uri: Uri?) {
                            println("✅ Imagem registrada no sistema: $uri")
                        }
                    })
            }
        } else {
            println("🚨 Erro ao capturar imagem ou ação cancelada pelo usuário.")
        }
    }
}
