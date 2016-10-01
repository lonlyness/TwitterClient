




//mentionの方を参照　ほぼ同一のもの






import UIKit
import TwitterKit
class TimeLineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var tableView: UITableView!
    
    var tweets: [TWTRTweet] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    　　　　　　  
    @IBOutlet weak var LogoutButton: UIButton!
    
    
    var prototypeCell: TWTRTweetTableViewCell?
        override func viewDidLoad() {
        super.viewDidLoad()
            tableView = UITableView()
            tableView.frame = CGRectMake(0, 60, self.view.bounds.width, self.view.bounds.height - 110);
            tableView.delegate = self
            tableView.dataSource = self
            prototypeCell = TWTRTweetTableViewCell(style: .Default, reuseIdentifier: "cell")
            tableView.registerClass(TWTRTweetTableViewCell.self, forCellReuseIdentifier: "cell")
            self.view.addSubview(tableView)
            self.view.sendSubviewToBack(tableView)
            loadTweets()
            
            LogoutButton.layer.cornerRadius = 3
            LogoutButton.layer.masksToBounds = true
    }
    
    func loadTweets() {
        var userId: String? = self.appDelegate.userId
        TwitterAPI.getHomeTimeline(userId,tweets: {
            twttrs in
            for tweet in twttrs {
                self.tweets.append(tweet)
            }
            }, error: {
                error in
                print(error.localizedDescription)
        })
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TWTRTweetTableViewCell
        let tweet = tweets[indexPath.row]
        cell.configureWithTweet(tweet)
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let tweet = tweets[indexPath.row]
        prototypeCell?.configureWithTweet(tweet)
        let height = TWTRTweetTableViewCell.heightForTweet(tweet,style: .Regular, width: self.view.bounds.width, showingActions: true)
        if !height.isNaN {
            return height - 40
        } else {
            return tableView.estimatedRowHeight
        }
    }
    
    
    
    @IBAction func LogoutAction(sender: AnyObject) {
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
    
    
    
}
