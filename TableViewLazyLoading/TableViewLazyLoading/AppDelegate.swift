//
//  AppDelegate.swift
//  TableViewLazyLoading
//
//  Created by Berdil İlyada Karacam on 13.04.2019.
//  Copyright © 2019 Berdil İlyada Karacam. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var securityView: UIView?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("didFinishLaunchingWithOptions")
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        addSecurityView()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        securityView?.removeFromSuperview()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func addSecurityView() {
        
        guard let window = window else { return }
        
        let securityView = UIView()
        securityView.backgroundColor = UIColor.white
        securityView.translatesAutoresizingMaskIntoConstraints = false
        window.addSubview(securityView)
        securityView.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
        securityView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
        securityView.leadingAnchor.constraint(equalTo: window.leadingAnchor).isActive = true
        securityView.trailingAnchor.constraint(equalTo: window.trailingAnchor).isActive = true
        
        let sampleLabel = UILabel()
        sampleLabel.text = "Security, Security, Security!"
        sampleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        sampleLabel.textColor = .black
        sampleLabel.numberOfLines = 0
        sampleLabel.translatesAutoresizingMaskIntoConstraints = false
        securityView.addSubview(sampleLabel)
        sampleLabel.centerXAnchor.constraint(equalTo: securityView.centerXAnchor).isActive = true
        sampleLabel.centerYAnchor.constraint(equalTo: securityView.centerYAnchor).isActive = true
        
        self.securityView = securityView
    }
    
}

