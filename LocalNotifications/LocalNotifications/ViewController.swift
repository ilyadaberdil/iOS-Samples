//
//  ViewController.swift
//  LocalNotifications
//
//  Created by Berdil İlyada Karacam on 26.05.2019.
//  Copyright © 2019 Berdil İlyada Karacam. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var notificationButton: UIButton! {
        didSet {
            notificationButton.setTitle("Register", for: .normal)
            notificationButton.backgroundColorAfterTapped = .purple
        }
    }
    
    @IBAction func notificationButtonTapped(_ sender: UIButton) {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert,.badge,.sound], completionHandler: { (granted, error) in
            if granted {
                print("yey")
            } else {
                print("D'oh!")
            }
        })
    }
    
    @IBOutlet weak var scheduleButton: UIButton! {
        didSet {
            scheduleButton.setTitle("Schedule", for: .normal)
        }
    }
    
    @IBAction func scheduleButtonTapped(_ sender: UIButton) {
        
        registerCategories()
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "CUSTOM NOTIFICATION TİTLE"
        content.body = "CUSTOM NOTIFICATION BODY"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzBuzz"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 15
        dateComponents.minute = 15
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        // if repeats true -> Time Interval should be at least 60.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func registerCategories() {

        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "TELL ME MORE", options: [.foreground])
        // increment Action
        let show2 = UNNotificationAction(identifier: "show2", title: "NOT TODAY", options: [.authenticationRequired,.destructive])
        
        let category = UNNotificationCategory(identifier: "alarm", actions: [show,show2], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category])
    }
    
}

extension ViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                //user swiped to unlock
                print("default identifier")
                
            case "show":
                print("show more information")
            
            case "show2":
                print(notificationButton.titleLabel?.text ?? "")
                
            default:
                break
            }
        }
        completionHandler()
    }
    
}


extension UIButton {
    
    private struct AssociatedKeys {
        static var backgroundColorAfterTapped = "backgroundColorAfterTapped"
    }
    
    var backgroundColorAfterTapped : UIColor? {
        get {
            guard let color = objc_getAssociatedObject(self, &AssociatedKeys.backgroundColorAfterTapped) as? UIColor else {
                return nil
            }
            return color
        }
        
        set(value) {
            objc_setAssociatedObject(self, &AssociatedKeys.backgroundColorAfterTapped, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        changeBackgroundWhenTapped()
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        changeBackgroundWhenTapped()
    }
    
    func changeBackgroundWhenTapped() {
        if let color = backgroundColorAfterTapped {
            let temps = backgroundColor
            backgroundColor = color
            backgroundColorAfterTapped = temps
        }
    }
}
