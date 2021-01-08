package com.jel.flutter_alarm

import io.flutter.app.FlutterApplication
import io.flutter.plugins.androidalarmmanager.AlarmService
import io.flutter.plugins.androidalarmmanager.AndroidAlarmManagerPlugin
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback

class Application : FlutterApplication(), PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
         AlarmService.setPluginRegistrant(this)
    }

    override fun registerWith(registry: io.flutter.plugin.common.PluginRegistry) {
        AndroidAlarmManagerPlugin.registerWith(
                registry.registrarFor("io.flutter.plugins.androidalarmmanager.AndroidAlarmManagerPlugin"))
    }
}