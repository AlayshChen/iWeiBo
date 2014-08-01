//
//  User.swift
//  iWeiBo
//
//  Created by Alaysh on 7/17/14.
//  Copyright (c) 2014 Alaysh. All rights reserved.
//

import Cocoa

class User: NSObject {
    var name: String
    var location: String
    var descriptions: String
    
    init(dic: NSDictionary) {
        name = dic["name"] as String
        location = dic["location"] as String
        descriptions = dic["description"] as String
    }
    
    func show() {
        print("--------------------------------------------------------------------------------")
        printGreenStr("\(name)  ")
        printYellowStr(descriptions)
        println("\n")
        printCyanStr(location)
        print("\n--------------------------------------------------------------------------------\n")
    }
}
