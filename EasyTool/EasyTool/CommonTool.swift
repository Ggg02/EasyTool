//
//  CommonTool.swift
//  EasyTool
//
//  Created by alex on 2017/3/22.
//  Copyright © 2017年 alex. All rights reserved.
//

import Foundation
import Cocoa

protocol CommonTool {
    
}

extension CommonTool{
    
  
    func openFolderDiag()->String{
        var retS:String = String()
        retS="./"
        
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose a foldee";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = true;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["txt"];
        
        if (dialog.runModal() == NSModalResponseOK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                let path = result!.path
                retS = path
                
            }
        }
        print(retS)
        return retS
        
        
    }
    func runShellCommand(command:[String])->String
    {
        var retS:String = String()
        let task = Process()
        task.launchPath = "/usr/bin/defaults"
        task.arguments = command
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        task.launch()
        task.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
        print(output)
        retS = output
        return retS
    }
    
    func getPathformParseString(s:String)->String{
        var retS:String = String()
        let t=s.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: ";", with: "").replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: " ", with: "").components(separatedBy: "=")
        retS=t[1]
        print(retS)
        return retS
    }
    func setlocation(withValue:String){
        var commandArray=["write","com.apple.screencapture","location"]
        commandArray.append(withValue)
        
        let temps=runShellCommand(command: commandArray)
        print("write Result:"+temps)
        
    }
    func getlocation()->String{
        var retS:String = String()
        let commandArray=["read","com.apple.screencapture"]
        let temps=runShellCommand(command: commandArray)
        retS=getPathformParseString(s: temps)
        
        return retS
        
    }
}

