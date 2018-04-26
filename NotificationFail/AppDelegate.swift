//
//  AppDelegate.swift
//  NotificationFail
//
//  Created by Brett Grace on 4/26/18.
//  Copyright © 2018 Brett Grace. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSUserNotificationCenterDelegate {

    var vc: ViewController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        NSUserNotificationCenter.default.delegate = self
        if let mainWindow = NSApp.mainWindow,
            let vc = mainWindow.contentViewController as? ViewController {
            self.vc = vc
        }
        
        vc?.append(text: "Contents of notification.userInfo:\n\(aNotification.userInfo?.debugDescription ?? "THAT'S IMPOSSIBLE")")
        
        if let _ = aNotification.userInfo?[NSApplication.launchUserNotificationUserInfoKey] as? NSUserNotification {
            vc?.foundNotificationCheckbox.state = .on
        } else {
            vc?.foundNotificationCheckbox.state = .off
        }

    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didDeliver notification: NSUserNotification) {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1) {
            NSApp.terminate(self)
        }
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        // Should never reach this because we close automatically, just added to rule out its presence/absence as contributing
        vc?.append(text: "Handling an action from NSUserNotification:\n\(notification.debugDescription)")
    }
    

}

