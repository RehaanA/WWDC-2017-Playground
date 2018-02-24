//
//  AppDelegate.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 11/23/16.
//  Copyright © 2016 Rehaan Advani. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var shortcutItem: UIApplicationShortcutItem?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
        // Override point for customization after application launch.
        self.window?.rootViewController = UINavigationController(rootViewController: ViewController())

        if let options = launchOptions,
            let shortcutItem = options[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            print("called")
            self.shortcutItem = shortcutItem
            return false
        }
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "SFUIText-Regular", size: 17)!], for: .normal)
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.backgroundColor = UIColor.clear
        
        return true
    }
    
    func triggerNotification() {
        if let shortcut = self.shortcutItem {
            self.handleQuickAction(shortcut)
        }
        self.shortcutItem = nil
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(handleQuickAction(shortcutItem))
    }
    
    func handleQuickAction(_ shortcutItem: UIApplicationShortcutItem) -> Bool {
        var quickActionHandled = false
        let type = shortcutItem.type.components(separatedBy: ".").last!
        if let shortcutType = Shortcut(rawValue: type) {
            switch shortcutType {
            case .aboutMe:
                NotificationCenter.default.addObserver(ViewController(), selector: #selector(ViewController.aboutMeTapped), name: NSNotification.Name(rawValue: "aboutMe"), object: nil)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "aboutMe"), object: nil)
                quickActionHandled = true
            case .projects:
                NotificationCenter.default.addObserver(ViewController(), selector: #selector(ViewController.projectsTapped), name: NSNotification.Name(rawValue: "projects"), object: nil)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "projects"), object: nil)
                quickActionHandled = true
            case .skills:
                NotificationCenter.default.addObserver(ViewController(), selector: #selector(ViewController.skillsTapped), name: NSNotification.Name(rawValue: "skills"), object: nil)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "skills"), object: nil)
                quickActionHandled = true
            case .wwdc2016:
                NotificationCenter.default.addObserver(ViewController(), selector: #selector(ViewController.wwdcTapped), name: NSNotification.Name(rawValue: "wwdc"), object: nil)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "wwdc"), object: nil)
                quickActionHandled = true
            }
        }
        return quickActionHandled
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

public enum Shortcut: String {
    case aboutMe = "About Me"
    case projects = "Projects"
    case skills = "Skills"
    case wwdc2016 = "WWDC 2016"
}

