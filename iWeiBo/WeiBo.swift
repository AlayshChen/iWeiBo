//
//  WeiBo.swift
//  iWeiBo
//
//  Created by Alaysh on 7/17/14.
//  Copyright (c) 2014 Alaysh. All rights reserved.
//

import Cocoa

class WeiBo: NSObject {
    var id: String
    var text: String
    var user: User!
    var created_at: String
    var retweeted_status: WeiBo!
    
    init(dic: NSDictionary) {
        id = dic["idstr"] as String
        text = dic["text"] as String
        if let retweetedDic = dic["retweeted_status"] as? NSDictionary {
            retweeted_status = WeiBo(dic: retweetedDic)
        }
        user = User(dic: dic["user"] as NSDictionary)
        created_at = (dic["created_at"] as NSString).substringToIndex(19)
    }
    func show() {
        print("--------------------------------------------------------------------------------")
        printGreenStr("\(user.name):")
        print(text)
        print("\n")
        if retweeted_status {
            print("    ")
            printGreenStr("\(retweeted_status.user.name):")
            print(retweeted_status.text)
            print("\n")
        }
        printCyanStr(created_at)
        print("\n")
        print("--------------------------------------------------------------------------------\n")
    }
}
