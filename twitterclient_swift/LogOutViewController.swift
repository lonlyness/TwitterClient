//
//  LogOutViewController.swift
//  Twitterclient
//
//  Created by ryota yamada on 2016/08/18.
//  Copyright © 2016年 TakumaNishimura. All rights reserved.
//







//    最終的につかっていないクラス






import UIKit
import TwitterKit

class LogOutViewController: UIViewController {
    
    @IBOutlet weak var Homebutton: UIButton!
    
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func Homebuttton(sender: AnyObject) {
        var userId: String? = appDelegate.userId
        self.performSegueWithIdentifier("first",sender: nil)
        let alert = UIAlertController(title: "Logout",
                                      message: "ログアウトしたよ！！",
                                      preferredStyle: UIAlertControllerStyle.Alert
        )
        alert.addAction(UIAlertAction(title: "Logout", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        if userId != nil {
            Twitter.sharedInstance().sessionStore.logOutUserID(userId!)
            print(userId)
                        self.appDelegate.userId = nil
            print(self.appDelegate.userId)
            self.performSegueWithIdentifier("first",sender: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

