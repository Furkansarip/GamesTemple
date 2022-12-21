//
//  LocalNotificationManager.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 17.12.2022.
//

import Foundation
import UserNotifications
import UIKit



class NotificationManager  {
    static let shared = NotificationManager()
    
    func localNotify(title:String,body:String,time:Double){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        let date = Date().addingTimeInterval(time)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        center.add(request) { (error) in
        }
    }
}
    
      
    

