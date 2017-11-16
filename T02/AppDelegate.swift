//
//  AppDelegate.swift
//  t02_Orange
//
//  Created by Ankita Kota on 10/28/17.
//  Copyright © 2017 Ankita Kota. All rights reserved.
//

import UIKit
var flag: Bool!
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var count = 0
    var lockStatus = 0
    var seconds1 : Int!
    var hours1 : Int!
    var minutes1 : Int!
    var currentDay : Int!
    var inTime: String!
    var outTime: String!
    
    let displayStatusChanged: CFNotificationCallback = { center, observer, name, object, info in
        let str = name!.rawValue as CFString
        if (str == "com.apple.springboard.lockcomplete" as CFString) {
            let isDisplayStatusLocked = UserDefaults.standard
            isDisplayStatusLocked.set(true, forKey: "isDisplayStatusLocked")
            isDisplayStatusLocked.synchronize()
            flag = true
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let isDisplayStatusLocked = UserDefaults.standard
        isDisplayStatusLocked.set(true, forKey: "isDisplayStatusLocked")
        isDisplayStatusLocked.synchronize()
        
        // Darwin Notification
        let cfstr = "com.apple.springboard.lockcomplete" as CFString
        let notificationCenter = CFNotificationCenterGetDarwinNotifyCenter()
        let function = displayStatusChanged
        CFNotificationCenterAddObserver(notificationCenter,
                                        nil,
                                        function,
                                        cfstr,
                                        nil,
                                        .deliverImmediately)
        return true
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    /* Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.*/
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        flag = false
        
        let state: UIApplicationState = UIApplication.shared.applicationState
        
        if state == UIApplicationState.inactive
        {
            print("sent to background by locking screen")
        }
        else if state == UIApplicationState.background
        {
            
            let isDisplayStatusLocked = UserDefaults.standard
            if let lock = isDisplayStatusLocked.value(forKey: "isDisplayStatusLocked")
            {
                
                
                let exitStr = "Lock Button Pressed!"
                let exitStatus = UserDefaults.standard
                exitStatus.set(exitStr, forKey: "exitStatus")
                exitStatus.synchronize()
                lockStatus = lockStatus + 1
                let date = Date()
                let calendar = Calendar.current
                var hour = calendar.component(.hour, from: date)
                var minutes = calendar.component(.minute, from: date)
                var seconds = calendar.component(.second, from: date)
                var day = calendar.component(.day, from: date)
                outTime = "\(hour):\(minutes):\(seconds)"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
                let currentDateString: String = dateFormatter.string(from: date)
                print("Current date is \(currentDateString)")
                print(outTime)
            }
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateExitStatus"), object: nil)
    }
    
    
    //  Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    func applicationWillEnterForeground(_ application: UIApplication) {
        //restore lock screen setting
        
        let isDisplayStatusLocked = UserDefaults.standard
        isDisplayStatusLocked.set(false, forKey: "isDisplayStatusLocked")
        isDisplayStatusLocked.synchronize()
        let date = Date()
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        var minutes = calendar.component(.minute, from: date)
        var seconds = calendar.component(.second, from: date)
        var day = calendar.component(.day, from: date)
        inTime = "\(hour):\(minutes):\(seconds)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        let currentDateString: String = dateFormatter.string(from: date)
        print("Current date is \(currentDateString)")
        print(inTime)
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    /* func getCurrentTime()
     {
     let date = Date()
     let calendar = Calendar.current
     var hour = calendar.component(.hour, from: date)
     var minutes = calendar.component(.minute, from: date)
     var seconds = calendar.component(.second, from: date)
     var day = calendar.component(.day, from: date)
     print("hours = \(hour):\(minutes):\(seconds)")
     //hour = hour * 3600
     //minutes = minutes * 60
     // seconds = hour + minutes + seconds
     //setUserScheduleStatus(hours: hour, minutes: minutes, seconds: seconds, day: day)
     }
     
     func setUserScheduleStatus(hours: Int, minutes: Int ,seconds:Int, day: Int)
     {
     
     /* if currentDay == day
     {
     totalGoodtime = goodTime
     totalBadtime = badTime
     }*/
     
     if count == 0
     {
     hours1 = hours
     minutes1 = minutes
     seconds1 = seconds
     count = count + 1
     return
     }
     
     if count == 1
     {
     let hours2 = hours
     let minutes2 = minutes
     let seconds2 = seconds
     //calculate the out time
     if lockStatus == 1
     {
     var Hours = hours2 - hours1
     var minutes = minutes2 - minutes1
     var Seconds = seconds2 - seconds1
     print("hours = \(Hours):\(minutes):\(Seconds)")
     }
     //calculate the in time
     else
     {
     var Hours = hours1 - hours2
     var minutes = minutes1 - minutes2
     var Seconds = seconds1 - seconds2
     lockStatus = 0
     }
     count = 0
     }
     }*/
}

