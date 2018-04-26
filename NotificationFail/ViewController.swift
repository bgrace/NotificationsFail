//
//  ViewController.swift
//  NotificationFail
//
//  Created by Brett Grace on 4/26/18.
//  Copyright © 2018 Brett Grace. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var withAdditionalActionButton: NSButton!
    @IBOutlet weak var withoutAdditionalActionButton: NSButton!
    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var foundNotificationCheckbox: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func append(text: String) {
        textView.textStorage?.append(NSAttributedString(string: "\(text)\n----------------\n"))
    }
    
    func buildNotification(title: String) -> NSUserNotification {
        let identifier = UUID().uuidString
        let notification = NSUserNotification()
        notification.informativeText = identifier
        notification.identifier = identifier
        notification.title = title
        return notification
    }
    
    @IBAction func withAdditionalActionPressed(_ sender: Any) {
        let notification = buildNotification(title: "With additional action!")
        notification.additionalActions = [
            NSUserNotificationAction(identifier: "one", title: "Action One"),
            NSUserNotificationAction(identifier: "two", title: "Action Two")
        ]
        NSUserNotificationCenter.default.deliver(notification)
    }
    
    @IBAction func withoutAdditionalActionPressed(_ sender: Any) {
        let notification = buildNotification(title: "Without additional action!")
        NSUserNotificationCenter.default.deliver(notification)

    }
    
    @IBAction func checkCheckbox(_ sender: NSButton) {
        // make it read-only
        if sender.state == .off {
            sender.state = .on
        } else {
            sender.state = .off
        }
    }
    
}

