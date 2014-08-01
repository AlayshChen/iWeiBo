//
//  System.swift
//  iWeiBo
//
//  Created by Alaysh on 7/18/14.
//  Copyright (c) 2014 Alaysh. All rights reserved.
//

import Cocoa

func runCommand(command: String) {
    var pipe = NSPipe.pipe()
    var task = NSTask()
    task.launchPath = "/bin/sh"
    task.arguments = ["-c", command]
    task.standardOutput = pipe
    var file = pipe.fileHandleForReading
    task.launch()
    let result = NSString(data: file.readDataToEndOfFile(), encoding: NSUTF8StringEncoding)
    println(result)
}

func getInput() -> String {
    let input = NSFileHandle.fileHandleWithStandardInput()
    let data: NSData! = input.availableData
    if data {
        let buf = NSString(data: data, encoding: NSUTF8StringEncoding)
        return buf.stringByReplacingOccurrencesOfString("\n", withString: "")
    }
    return ""
}
