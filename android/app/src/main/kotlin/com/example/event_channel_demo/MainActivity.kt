package com.example.event_channel_demo

import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.EventChannel
import java.util.*
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val handler = Handler(Looper.getMainLooper())
    private val CHANNEL = "exampleMethodChannel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getMessage" -> result.success("Hello from Android!")
                "calculateSum" -> {
                    val a = call.argument<Int>("a") ?: 0
                    val b = call.argument<Int>("b") ?: 0
                    val sum = calculateSum(a, b)
                    result.success(sum)
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Set up an EventChannel for device information
        val deviceEventChannel = EventChannel(
            flutterEngine?.dartExecutor?.binaryMessenger,
            DEVICE_EVENT_CHANNEL_NAME
        )

        // Send device information to Flutter
        handler.postDelayed({
            val deviceInfo = getDeviceInfo()
            deviceEventChannel.setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
                    eventSink.success(deviceInfo)
                }

                override fun onCancel(arguments: Any?) {
                    // Handle cancellation
                }
            })
        }, 1000)

        // Set up an EventChannel for sending a string to Flutter
        val stringEventChannel = EventChannel(
            flutterEngine?.dartExecutor?.binaryMessenger,
            STRING_EVENT_CHANNEL_NAME
        )

        // Example: send a string from native to Flutter every 2 seconds
        handler.postDelayed({
            sendStringToFlutter("Hello from native!")
            // You can change the string or the frequency as needed
        }, 2000)
    }

    private fun getDeviceInfo(): Map<String, Any> {
        val deviceInfo = HashMap<String, Any>()
        deviceInfo["model"] = Build.MODEL
        deviceInfo["brand"] = Build.BRAND
        deviceInfo["version"] = Build.VERSION.RELEASE
        // Add more information as needed

        return deviceInfo
    }

    private fun sendStringToFlutter(message: String) {
        val stringEventChannel = EventChannel(
            flutterEngine?.dartExecutor?.binaryMessenger,
            STRING_EVENT_CHANNEL_NAME
        )
        stringEventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
                eventSink.success(message)
            }

            override fun onCancel(arguments: Any?) {
                // Handle cancellation
            }
        })
    }

    companion object {
        private const val DEVICE_EVENT_CHANNEL_NAME = "deviceEventChannel"
        private const val STRING_EVENT_CHANNEL_NAME = "stringEventChannel"
    }



    private fun calculateSum(a: Int, b: Int): Int {
        return a + b
    }
}
