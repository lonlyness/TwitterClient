
import Foundation
import TwitterKit

class TwitterAPI {
    let baseURL = "https://api.twitter.com"
    let version = "/1.1"
    init() {
    }
    
    
    
    // mentionとtimeline ではとってくるファイルが異なるだけ
    
    
    
    class func getHomeTimeline(user: String?, tweets: [TWTRTweet]->(), error: (NSError) -> ()) {
        let api = TwitterAPI()
        let client = TWTRAPIClient(userID: user)
        print(client);
        var clientError: NSError?
        let path = "/statuses/home_timeline.json"
        let endpoint = api.baseURL + api.version + path
        let request:NSURLRequest? = client.URLRequestWithMethod("GET",
                                                                URL: endpoint,
                                                                parameters: nil,
                                                                error: &clientError)

        if request != nil {
            client.sendTwitterRequest(request!, completion: {
                response, data, err in
                if err == nil {
                    do {
                        let json: AnyObject? = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                        if let jsonArray = json as? NSArray {
                            tweets(TWTRTweet.tweetsWithJSONArray(jsonArray as [AnyObject]) as! [TWTRTweet])
                        }
                    } catch {
                        print("error")
                    }
                } else {
                    error(err!)
                }
            })
        }
    }
    
    class func getMention(user: String?, tweets: [TWTRTweet]->(), error: (NSError) -> ()) {
        let api = TwitterAPI()
        let client = TWTRAPIClient(userID: user)
        var clientError: NSError?
 
        let path = "/statuses/mentions_timeline.json"
        let endpoint = api.baseURL + api.version + path
        let request:NSURLRequest? = client.URLRequestWithMethod("GET",
                                                                URL: endpoint,
                                                                parameters: nil,
                                                                error: &clientError)
        if request != nil {
            client.sendTwitterRequest(request!, completion: {
                response, data, err in
                if err == nil {
                    do {
                        let json: AnyObject? = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                        if let jsonArray = json as? NSArray {
                            tweets(TWTRTweet.tweetsWithJSONArray(jsonArray as [AnyObject]) as! [TWTRTweet])
                        }
                    } catch {
                        print("error")
                    }
                } else {
                    error(err!)
                }
            })
        }
    }
    
}
