package com.abilia.abilia_notifications

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import kotlin.random.Random

class AbiliaNotificationsPlugin: MethodCallHandler {

  companion object {
    private const val CHANNEL_ID = "my-channel-id"

    private lateinit var registrar: Registrar
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      this.registrar = registrar
      val channel = MethodChannel(registrar.messenger(), "abilia_notifications")
      channel.setMethodCallHandler(AbiliaNotificationsPlugin())
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "setNotification") {
        setNotification()
    } else {
      result.notImplemented()
    }
  }

  private fun setNotification() {
    Log.i("Tag", "Message is in tha house")
    createNotificationChannel()
    val builder = NotificationCompat.Builder(registrar.context(), CHANNEL_ID)
            .setSmallIcon(android.R.drawable.ic_media_next)
            .setContentTitle("A titlellll")
            .setContentText("A contentttt")
            .setPriority(NotificationCompat.PRIORITY_MAX)
    val id = Random(1).nextInt()
    getNotificationManager(registrar.context()).notify(id, builder.build())
    Log.i("Tag", "Everything is done!")
  }

  private fun createNotificationChannel() {
    // Create the NotificationChannel, but only on API 26+ because
    // the NotificationChannel class is new and not in the support library
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      val name = "Channel name"
      val descriptionText = "Channel description"
      val importance = NotificationManager.IMPORTANCE_MAX
      val channel = NotificationChannel(CHANNEL_ID, name, importance).apply {
        description = descriptionText
      }
      // Register the channel with the system
      val notificationManager: NotificationManagerCompat = getNotificationManager(registrar.context())
      notificationManager.createNotificationChannel(channel)
    }
  }

  private fun getNotificationManager(context: Context): NotificationManagerCompat {
    return NotificationManagerCompat.from(context)
  }
}