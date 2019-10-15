import Flutter
import UIKit

@available(iOS 10.0, *)
public class SwiftAbiliaNotificationsPlugin: NSObject, FlutterPlugin, UNUserNotificationCenterDelegate {
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "abilia_notifications", binaryMessenger: registrar.messenger())
    let instance = SwiftAbiliaNotificationsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    let center = UNUserNotificationCenter.current()
    center.delegate = instance
    requestPermissionToShowNotifications()
  }
  
  static func requestPermissionToShowNotifications() {
    UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
      if granted {
        DispatchQueue.main.async(execute: {
          UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound] , categories: nil))
        })
      }
    }
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "initialize":
      let initString = initialize();
      result(initString)
    case "getPlatformVersion":
      result("getPlatformVersion" + UIDevice.current.systemVersion)
    case "setNotification":
      let notText = setNofification()
      result(notText + UIDevice.current.systemVersion)
    default:
      result("default" + UIDevice.current.systemVersion)
    }
  }
  
  public func initialize() -> String {
    // Do initialization here
    
    
    
    return "init ok"
  }
  
  public func setNofification() -> String {
    if #available(iOS 10.0, *) {
      print("Ios is more than 10")
      let content = UNMutableNotificationContent()
      content.title = "Testing abilia nooooooot"
      content.body = "Yes it is!"
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
      let uuidString = UUID().uuidString
      let request = UNNotificationRequest(identifier: uuidString,
                                          content: content, trigger: trigger)
      
      let notificationCenter = UNUserNotificationCenter.current()
      notificationCenter.add(request) { (error) in
        if error != nil {
          print("Some error")
        }
      }
    } else {
      // Fallback on earlier versions
    }
    return "loooow"
  }
}
