//
//  AppDelegate.swift
//  Twitterclient
//
//  Created by ryota yamada on 2016/08/09.
//  Copyright © 2016年 TakumaNishimura. All rights reserved.
//

import UIKit
import Fabric
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {//  :　で継承している　
    
    var window: UIWindow?
    
    var userId:String?
    var userName:String?   // 値を渡すための変数
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Fabric.with([Twitter.self])
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
           }
    
    func applicationWillEnterForeground(application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
       
    }
    
    func applicationWillTerminate(application: UIApplication) {
           }
    
    
}
