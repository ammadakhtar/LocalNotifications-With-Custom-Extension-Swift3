//
//  NotificationViewController.swift
//  ExtensionContent
//
//  Created by Ammad on 11/04/2017.
//  Copyright © 2017 Ammad. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        guard let attachment = notification.request.content.attachments.first else {
            return
        }
        if attachment.url.startAccessingSecurityScopedResource() {
            let imageData = try? Data.init(contentsOf : attachment.url)
            if let img = imageData {
                image.image = UIImage(data: img)
            }
        }
        
    }
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if response.actionIdentifier == "gotoapp" {
            completion(.dismissAndForwardAction)
        } else if response.actionIdentifier == "dismiss" {
            completion(.dismissAndForwardAction)
        }
    }
}
