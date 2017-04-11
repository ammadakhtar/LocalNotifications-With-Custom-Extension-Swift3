//
//  ViewController.swift
//  Notifications
//
//  Created by Ammad on 11/04/2017.
//  Copyright © 2017 Ammad. All rights reserved.
// to present notifcation within app means to show notification even if the app is opened see the extension inplemented in AppDelegate.swift and import UserNotifcations in AppDelegate.swift too. Add  UNUserNotificationCenter.current().delegate = self in didfinishlaunching function.

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //ask for permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (granted, error) in
            if granted{
                print("Notifications access granted")
            }
            else {
                print( error?.localizedDescription as Any)
            }
        }
        
        
    }
    
    @IBAction func notificationBtnPressed(_ sender: UIButton) {
        
        sendnotification(inSeconds: 5) { success in
            if success {
                print("success")
            } else {
                print("error")
            }
        }
        
    }
    //configure notificatoins
    
    func sendnotification(inSeconds: TimeInterval , completion: @escaping (_ Success: Bool) -> ()){
        let notif = UNMutableNotificationContent()
    //notification attachment
        let imageUrl = Bundle.main.url(forResource: "giphy-tumblr", withExtension: "gif")
        var attachment : UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl!, options: .none)
   //notifications content
        
        //for notication extension only 
        notif.categoryIdentifier = "myNotificationCategory"
        notif.title = "Notification Title"
        notif.subtitle = "Notification Subtitle"
        notif.body = "Notification Body"
        notif.attachments = [attachment]
        
        let notiftrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds , repeats: false)
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notiftrigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print(error!)
                completion(false)
            } else {
                completion(true)
            }
        }
        
    }
    
    
    
    
}

