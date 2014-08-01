//
//  RESTEngine.swift
//  iWeiBo
//
//  Created by Alaysh on 7/17/14.
//  Copyright (c) 2014 Alaysh. All rights reserved.
//

import Cocoa

let kUid = "2839054733"
let kAppKey = "3063462897"
let kAccessToken = "2.004p4IGDtdy_2D72d2a9f108tDcuED"
let kHostUrl = "https://api.weibo.com"
let kPublicJson = "/2/statuses/public_timeline.json"
let kFriendJson = "/2/statuses/friends_timeline.json"
let kMyWeiBoJson = "/2/statuses/user_timeline.json"
let kShowJson = "/2/users/show.json"
let kUpdateJson = "/2/statuses/update.json"
let kCommentShowJson = "/2/comments/show.json"
let kCreateJson = "/2/comments/create.json"

class RESTEngine: NSObject {
    class func httpRequest(method: String, action: String, query :String, successClosure:(jsonDic: NSDictionary!)->(), errorClosure:(error: NSError!)->()) {
        var url: NSURL!
        var urlRequest: NSMutableURLRequest!
        if method == "POST" {
            url = NSURL(string: "\(kHostUrl)\(action)")
            urlRequest = NSMutableURLRequest(URL: url)
            urlRequest.HTTPMethod = "POST"
            urlRequest.HTTPBody = query.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        }
        else if method == "GET" {
            url = NSURL(string: "\(kHostUrl)\(action)?\(query)")
            urlRequest = NSMutableURLRequest(URL: url)
            urlRequest.HTTPMethod = "GET"
        }
        else {
            //Delete
        }
        let urlSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let dataTask = urlSession.dataTaskWithRequest(urlRequest, completionHandler: {data, response, error in
            let jsonError: AutoreleasingUnsafePointer<NSError?> = nil
            
                if error {
                    errorClosure(error: error)
                }
                else {
                    let jsonData:NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: jsonError) as NSDictionary
                    successClosure(jsonDic: jsonData)
                }
            })
        dataTask.resume()
    }
    
    class func getPublicWeibo(param: NSDictionary = [:], success:(array: [AnyObject])->(), errors:(error:NSError!)->()){
        let page: AnyObject! = param["page"]
        let queryParam = "access_token=\(kAccessToken)&page=\(page)&count=4"
        
        httpRequest("GET", action: kPublicJson, query: queryParam, successClosure:
            {
                jsonDic in
                let weibosJson: NSArray = jsonDic["statuses"] as NSArray
                var weibos:NSMutableArray = []
                for dic in weibosJson as [NSDictionary] {
                    let weibo = WeiBo(dic: dic)
                    weibos.addObject(weibo)
                }
                success(array: weibos)
            }, errorClosure: {
                error in errors(error: error)
            })
    }
    
    class func getFrinendsWeibo(param: NSDictionary = [:], success:(array: [AnyObject])->(), errors:(error:NSError!)->()){
        let page: Int! = param["page"] as Int
        let queryParam = "source=\(kAppKey)&access_token=\(kAccessToken)&page=\(page)&count=4"
        
        httpRequest("GET", action: kFriendJson, query: queryParam, successClosure:
        {
            jsonDic in
            let weibosJson: NSArray = jsonDic["statuses"] as NSArray
            var weibos:NSMutableArray = []
            for dic in weibosJson as [NSDictionary] {
                let weibo = WeiBo(dic: dic)
                weibos.addObject(weibo)
            }
            success(array: weibos)
        }, errorClosure: {
            error in errors(error: error)
        })
    }
    
    class func postNewWeiBo(param: NSDictionary = [:], success:(array: [AnyObject])->(), errors:(error:NSError!)->()){
        let status: String! = param["status"] as String
        let queryParam = "access_token=\(kAccessToken)&status=\(status)"
        
        httpRequest("POST", action: kUpdateJson, query: queryParam, successClosure:
            {
                jsonDic in
                let weibo = WeiBo(dic: jsonDic)
                success(array: [weibo])
            }, errorClosure: {
                error in errors(error: error)
            })
    }
    
    class func getMyWeiBo(param: NSDictionary = [:], success:(array: [AnyObject])->(), errors:(error:NSError!)->()){
        let page: AnyObject! = param["page"]
        let queryParam = "access_token=\(kAccessToken)&uid=\(kUid)&page=\(page)&count=4"
        
        httpRequest("GET", action: kMyWeiBoJson, query: queryParam, successClosure:
            {
                jsonDic in
                let weibosJson: NSArray = jsonDic["statuses"] as NSArray
                var weibos:NSMutableArray = []
                for dic in weibosJson as [NSDictionary] {
                    let weibo = WeiBo(dic: dic)
                    weibos.addObject(weibo)
                }
                success(array: weibos)
            }, errorClosure: {
                error in errors(error: error)
            })
    }
    
    class func getMyAccountMessage(param: NSDictionary = [:], success:(array: [AnyObject])->(), errors:(error:NSError!)->()){
        let queryParam = "access_token=\(kAccessToken)&uid=\(kUid)"
        
        httpRequest("GET", action: kShowJson, query: queryParam, successClosure:
            {
                jsonDic in
                let user = User(dic: jsonDic)
                success(array: [user])
            }, errorClosure: {
                error in errors(error: error)
            })
    }
    
    class func searchUser(param: NSDictionary = [:], success:(array: [AnyObject])->(), errors:(error:NSError!)->()){
        let page: AnyObject! = param["page"]
        let queryParam = "access_token=\(kAccessToken)&page=\(page)&count=4"
        
        httpRequest("GET", action: kFriendJson, query: queryParam, successClosure:
            {
                jsonDic in
                let weibosJson: NSArray = jsonDic["statuses"] as NSArray
                for dic in weibosJson as [NSDictionary] {
                    let weibo = WeiBo(dic: dic)
                    weibo.show()
                }
            }, errorClosure: {
                error in errors(error: error)
            })
    }
    
    class func getCommont(param: NSDictionary = [:], success:(array: [AnyObject])->(), errors:(error:NSError!)->()){
        let page: AnyObject! = param["page"]
        let id: AnyObject! = param["id"]
        let queryParam = "access_token=\(kAccessToken)&id=\(id)&page=\(page)&count=5"
        httpRequest("GET", action: kCommentShowJson, query: queryParam, successClosure:
            {
                jsonDic in
                let commentsJson: NSArray = jsonDic["comments"] as NSArray
                var comments: NSMutableArray = []
                for dic in commentsJson as [NSDictionary] {
                    let comment = WeiBo(dic: dic)
                    comments.addObject(comment)
                }
                success(array: comments)
            }, errorClosure: {
                error in errors(error: error)
            })
    }
    
    class func postCommont(param: NSDictionary = [:], success:(array: [AnyObject])->(), errors:(error:NSError!)->()){
        let comment: AnyObject! = param["comment"]
        let id: AnyObject! = param["id"]
        let queryParam = "access_token=\(kAccessToken)&comment=\(comment)&id=\(id)"
        httpRequest("POST", action: kCreateJson, query: queryParam, successClosure:
            {
                jsonDic in
                let weibo = WeiBo(dic: jsonDic)
                success(array: [weibo])
            }, errorClosure: {
                error in errors(error: error)
            })
    }
}
