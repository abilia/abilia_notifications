import Flutter
import UIKit

@available(iOS 10.0, *)
public class SwiftAbiliaNotificationsPlugin: NSObject, FlutterPlugin, UNUserNotificationCenterDelegate {
  static var PRESENT_WHILE_APP_OPEN_KEY = "present_while_app_open_key"
  
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
    case "setNotification":
      let args : NSArray = call.arguments as! NSArray
      setNofification(args: args)
      result(nil)
    default:
      result(nil)
    }
  }
  
  public func setNofification(args: NSArray) -> Void {
    let argsMap : NSDictionary = args[0] as! NSDictionary
    let title : String = argsMap["title"] as! String
    let body : String = argsMap["body"] as! String
    let millisecondsSinceEpoch : Double = argsMap["millisecondsSinceEpoch"] as! Double
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = UNNotificationSound.default()
    
    let date = Date(timeIntervalSince1970: millisecondsSinceEpoch / 1000)
    print("The date is:")
    print(date)
    let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    
    let uuidString = UUID().uuidString
    let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
    
    let center = UNUserNotificationCenter.current()
    center.add(request) { (error) in
      // Check for errors
    }
  }
  
  public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                     willPresent: UNNotification,
                                     withCompletionHandler: @escaping (UNNotificationPresentationOptions)->()) {
    withCompletionHandler([.alert, .sound, .badge])
  }
}
