
import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    
    
    
        @IBOutlet weak var Logout: UIButton!
    　　　
        
        @IBOutlet weak var TimeLineButton: UIButton!
    
        @IBOutlet weak var gazou1: UIImageView!
    
        @IBOutlet weak var LoginButton: UIButton! = UIButton()
    
        @IBOutlet weak var AxisLog: UIImageView! = UIImageView()
    
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate　// appdelegateをつかって値を渡すときのおまじない　appdelegateで値を渡すときにはこの一文と　どこに値をいれるかの文(下にある)が必要
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            LoginButton.layer.cornerRadius = 14
            LoginButton.layer.masksToBounds = true　//この２文で角をまるくしている
            
            TimeLineButton.layer.cornerRadius = 14
            TimeLineButton.layer.masksToBounds = true
            
            AxisLog.layer.cornerRadius = 15
            AxisLog.layer.masksToBounds = true
            
            TimeLineButton.hidden = true;　//かくしている
            
            //LoginButton.hidden = false;
    }
    
    
        @IBAction func LoginAction(sender: AnyObject) {
            
            Twitter.sharedInstance().logInWithCompletion { session, error in
                if (session != nil) {
                    print("signed in as \(session!.userName)");
                    self.appDelegate.userId = session?.userID
                    self.appDelegate.userName = session?.userName　//appDelegate に値を渡してどのViewからでも取得できるようにしている。appdelegateのなかにuserIdやuserNameがかいてある
                    self.LoginButton.hidden = true;
                    self.TimeLineButton.hidden = false;
                } else {
                    print("error: \(error!.localizedDescription)");
                }
            }
            
        }
    
    
        @IBAction func TimeLineA(sender: AnyObject) {
        }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()　//　メモリがやばいときの対処
        }
}