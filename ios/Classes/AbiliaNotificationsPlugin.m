#import "AbiliaNotificationsPlugin.h"
#import <abilia_notifications/abilia_notifications-Swift.h>

@implementation AbiliaNotificationsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAbiliaNotificationsPlugin registerWithRegistrar:registrar];
}
@end
