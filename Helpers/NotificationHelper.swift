//
//  NotificationHelper.swift
//  carpino-passenger-ios-swift
//
//  Created by ali on 1/14/20.
//  Copyright © 2020 carpino corp. All rights reserved.
//

import UIKit

class NotificationHelper {

    class func removeAllPendingNotifications(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    class func removeAllDeliveredNotifications(){
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }

    class func sendLocalNotification(title: String, body: String, identifier: String = UUID().uuidString) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request){
            (error) in
            if let error = error {
                CLog.i("send local notification Error: \(error)")
            }
        }
    }

}
