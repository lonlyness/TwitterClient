
import UIKit
import TwitterKit
class MentionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView!
    var tweets: [TWTRTweet] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var prototypeCell: TWTRTweetTableViewCell?
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    //@IBOutlet weak var Logout: UIButton!
       
    @IBOutlet weak var logout: UIButton!　//IBOutlet接続している
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()　//tableviewの生成
        tableView.frame = CGRectMake(0, 60, self.view.bounds.width, self.view.bounds.height - 110);//ツイートを画面の中でどの位置に表示させるかを定義している。
        tableView.delegate = self
        tableView.dataSource = self
        prototypeCell = TWTRTweetTableViewCell(style: .Default, reuseIdentifier: "cell")
        tableView.registerClass(TWTRTweetTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)         //表示させている
        self.view.sendSubviewToBack(tableView)
        loadTweets()                            //ツイートをロード
        
        logout.layer.cornerRadius = 3
        logout.layer.masksToBounds = true　// ボタンの角を丸くしてる
    }
    
    func loadTweets() {
        
        var userId: String? = appDelegate.userId        //appDelegateから値をもってきている
        TwitterAPI.getMention(userId,tweets: {
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
        return self.tweets.count　// ツイートの行数を決定しているらしい
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TWTRTweetTableViewCell
        let tweet = tweets[indexPath.row]
        cell.configureWithTweet(tweet)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let tweet = tweets[indexPath.row]
        return TWTRTweetTableViewCell.heightForTweet(tweet,style: .Regular, width: self.view.bounds.width, showingActions: true) - 40　//ツイートの幅を決定しているらしい
    }
    
    
    
    @IBAction func logout(sender: AnyObject) {　//logoutメソッド
        var userId: String? = appDelegate.userId   // userIdをappdelegateから引っ張ってきてる
        self.performSegueWithIdentifier("first",sender: nil)　// segueをつかって画面遷移 segue の　identifierにfirstを設定している
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
            self.performSegueWithIdentifier("second",sender: nil)　// ifからいらないかも笑
        }
    }
    
    
    
}
