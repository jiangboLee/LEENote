//
//  SourceEditorCommand.swift
//  LeeNote
//
//  Created by ljb48229 on 2017/11/29.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        // 第一个选中区域
        let firstSelectObject: XCSourceTextRange = invocation.buffer.selections.firstObject as! XCSourceTextRange
        let buffer = invocation.buffer
       
        var start = firstSelectObject.start.line
        var end = firstSelectObject.end.line
        var startStr: String = buffer.lines[start] as! String
        var endStr: String = buffer.lines[end] as! String
        
        if start == end {
            
        } else {
            
            while checkSpace(str: endStr) {
                if end == start {
                    break
                }
                end -= 1
                endStr = buffer.lines[end] as! String
            }
            while checkSpace(str: startStr) {
                start += 1
                startStr = buffer.lines[start] as! String
            }
        }
        
        if  startStr.hasPrefix("/**") && endStr.hasPrefix("*/") {
            buffer.lines.removeObject(at: end)
            buffer.lines.removeObject(at: start)
            completionHandler(nil)
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "zh_CN") as Locale!
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let str = dateFormatter.string(from: NSDate() as Date)
        
        buffer.lines.insert("*/", at: end + 1)
        buffer.lines.insert("/** \(str)", at: start)
    

        completionHandler(nil)
    }

    /// 是否为全是空格
    func checkSpace(str: String) -> Bool {
        if (str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString).length == 0 {
            return true
        }
        return false
    }
    
}
