//
//  Menu.swift
//  iWeiBo
//
//  Created by Alaysh on 7/18/14.
//  Copyright (c) 2014 Alaysh. All rights reserved.
//

import Cocoa
let title = "欢迎使用iWeiBo"
let dataList = ["0.微博广场",
                "1.最新微博",
                "2.发微博",
                "3.我的微博",
                "4.我的信息",
                "5.搜索",
                "6.帮助"]
let helpList = ["p: previous    上一页",
                "n: next        上一页",
                "h: home        主页",
                "c + kth:       评论第k条微博",
                "l + kth:       查看第k条微博"]

class Menu: NSObject {
    func start() {
        var page = 1;
        var result: [AnyObject] = []
        var preFunHandle = RESTEngine.getPublicWeibo
        var funhandle = RESTEngine.getPublicWeibo
        var param: NSMutableDictionary = [:]
        runCommand("clear")
        showMenu()
        while(true) {
            let choice = getInput()
            runCommand("clear")
            switch choice {
            case "0":
                print("                                  \(dataList[0])\n")
                page = 1
                param = ["page": page]
                funhandle = RESTEngine.getPublicWeibo
                funhandle(param: param, success: {array in
                    result = array
                    for obj in array {
                        let weibo = obj as WeiBo
                        weibo.show()
                    }}, errors: {error in println(error)})
            case "1":
                print("                                  \(dataList[1])\n")
                page = 1
                param = ["page": page]
                funhandle = RESTEngine.getFrinendsWeibo
                 funhandle(param: param, success: {array in
                    result = array
                    for obj in array {
                        let weibo = obj as WeiBo
                        weibo.show()
                    }}, errors: {error in println(error)})
            case "2":
                print("                                  \(dataList[2])\n")
                print("请输入微博内容:\n")
                let text = getInput()
                funhandle = RESTEngine.postNewWeiBo
                 funhandle(param: ["status":text], success: {array in
                    println("发布微博成功！")
                    for obj in array {
                        let weibo = obj as WeiBo
                        weibo.show()
                    }}, errors: {error in println(error)})
            case "3":
                print("                                  \(dataList[3])\n")
                page = 1
                param = ["page": page]
                funhandle = RESTEngine.getMyWeiBo
                funhandle(param: param, success: {array in
                    result = array
                    for obj in array {
                        let weibo = obj as WeiBo
                        weibo.show()
                    }}, errors: {error in println(error)})
            case "4":
                print("                                  \(dataList[4])\n")
                funhandle = RESTEngine.getMyAccountMessage
                funhandle(param: [:], success: {array in
                    result = array
                    for obj in array {
                        let user = obj as User
                        user.show()
                    }}, errors: {error in println(error)})
            case "5":
                print("                                  \(dataList[5])\n")
                page = 1
                param = ["page": page]
                funhandle = RESTEngine.searchUser
                funhandle(param: param, success: {array in }, errors: {error in println(error)})
            case "6":
                print("                                  \(dataList[6])\n")
                help()
            case "p":
                page -= 1
                if page <= 0 {
                    page = 1
                }
                param["page"] = page
                funhandle(param: param, success: {array in
                    for obj in array {
                        if let weibo = obj as? WeiBo {
                            weibo.show()
                        }
                        else if let user = obj as? User {
                            user.show()
                        }
                    }}, errors: {error in println(error)})
            case "n", "N":
                page += 1
                param["page"] = page
                funhandle(param: param, success: {array in
                    result = array
                    for obj in array {
                        if let weibo = obj as? WeiBo {
                            weibo.show()
                        }
                        else if let user = obj as? User {
                            user.show()
                        }
                    }}, errors: {error in println(error)})
            case let x  where x.hasPrefix("c "):
                if let index = (x as NSString).substringFromIndex(2).toInt() {
                    if let weibo = result[index] as? WeiBo {
                        let id = weibo.id
                        funhandle = RESTEngine.getCommont
                        weibo.show()
                        
                        print("请输入你的评论内容:\n")
                        let text = getInput()
                        RESTEngine.postCommont(param: ["comment": text, "id": id], success: {array in
                            println("评论成功！")
                            for obj in array {
                                let weibo = obj as WeiBo
                                weibo.show()
                            }}, errors: {error in println(error)})
                    }
                }
            case let x where x.hasPrefix("l "):
                if let index = (x as NSString).substringFromIndex(2).toInt() {
                    if let weibo = result[index] as? WeiBo {
                        weibo.user.show()
                        weibo.show()
                        println("评论列表")
                        let id = weibo.id
                        page = 1
                        param["page"] = page
                        param["id"] = id
                        funhandle = RESTEngine.getCommont
                        funhandle(param: param, success: {array in
                            for obj in array {
                                if let comment = obj as? WeiBo {
                                    comment.show()
                                }
                            }}, errors: {error in println(error)})
                    }
                }
            case "h":
                start()
            default:
                //Do nothing
//                start()
                for obj in result {
                    if let weibo = obj as? WeiBo {
                        weibo.show()
                    }
                    else if let user = obj as? User {
                        user.show()
                    }
                }
            }
        }
    }
    
    func showMenu() {
        print("                                  \(title)\n")
        println("--------------------------------------------------------------------------------")
        for i in 0..<dataList.count {
            print("                                  ")
            printStr(dataList[i],i)
            print("\n")
        }
        println("--------------------------------------------------------------------------------")
    }
    
    func help() {
        println("--------------------------------------------------------------------------------")
        for i in 0..<helpList.count {
            printStr(helpList[i], i)
            print("\n")
        }
        println("--------------------------------------------------------------------------------")
    }
}
