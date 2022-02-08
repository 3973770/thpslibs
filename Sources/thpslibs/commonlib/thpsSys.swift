//
//  thpsSys.swift
//  
//
//  Created by Kostiantyn Bohonos on 2/7/22.
//

import Foundation

// MARK: SYSTEM
//--------------------------------------

public struct thpsSys{
    
    /// Execute shell command
    public static func shell(_ command: String) -> String {
        var output:String = ""
        do {
            let task = Process()
            #if os(Linux)
            task.executableURL = URL(fileURLWithPath: "/bin/bash")
            #else
            if #available(OSX 10.13, *) {
                task.executableURL = URL(fileURLWithPath: "/bin/bash")
            }
            #endif
            task.arguments = ["-c", command]
            task.standardOutput = Pipe()
            #if os(Linux)
            try task.run()
            #else
            if #available(OSX 10.13, *) {
                try task.run()
            }
            #endif
            let pipe:Pipe = task.standardOutput as! Pipe
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            output = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
            pipe.fileHandleForReading.closeFile()
        } catch {}
        return output
    }
}
