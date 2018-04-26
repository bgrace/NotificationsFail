# NotificationsFail
Demonstration of bug with `NSUserNotification` not being delivered upon relaunching its originating app if additional actions are
attached to the notification.

If an app presents an `NSUserNotification` and then closes, clicking on the notification relaunches the app. According to the documentation,
the NSUserNotification which was clicked on is supposed to be present in the `Notification` posted to the `AppDelegate` in its
`applicationDidFinishLaunching(_: Notification)` handler.

[Apple Developer Documentation](https://developer.apple.com/documentation/foundation/nsusernotificationcenterdelegate/1418378-usernotificationcenter):

> To take an action when your application is launched as a result
> of a user clicking on a notification, be sure to implement the
> applicationDidFinishLaunching(_:) method in the application class
> that implements the NSApplicationDelegate protocol. The
> notification parameter to that method has a userInfo dictionary,
> and if that dictionary has the
> NSApplicationLaunchUserNotificationKey key. The value of that key
> is the NSUserNotification object that caused the application to
> launch. The NSUserNotification object is delivered to the
> NSApplication delegate because that message will be sent before
> your application has a chance to set a delegate for the
> NSUserNotificationCenter.

This specification is violated if the notification has `additionalActions` set, making it impossible to know if the app was launched as 
a result of the user interacting with a notification, or to determine what that interaction was.

This app presents a window to the user on launching, and logs the contents of the `didFinishLaunching:notification.userInfo` dictionary to a text view. Use one of
the two buttons to present a notification (with, or without, additional actions). The app will close automatically. If you select
the action button of the notification without additional actions, the app will relaunch and show that it has found the original
`NSUserNotification` in its launch environment, as the documentation states. If you select the button with additional actions, this
information is _not_ added to the launch environment.

Behavior confirmed on:
- macOS Sierra 10.12.6 with Xcode 9.2 and Swift 4.0
- macOS High Sierra 10.13.4 with Xcode 9.3 and Swift 4.0

