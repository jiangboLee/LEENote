//
//  SourceEditorExtension.swift
//  LeeNote
//
//  Created by ljb48229 on 2017/11/29.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorExtension: NSObject, XCSourceEditorExtension {
    
    /*
     //指刚刚加载好插件但还未点击插件按钮时，可以执行某些准备工作。
    func extensionDidFinishLaunching() {
        // If your extension needs to do any work at launch, implement this optional method.
    }
    */
    //变量commandDefinitions返回字典类型的数组，可以为每个插件重写名字、标识符和自定义类名等信息，相当于设置后面要介绍的的Info.plist文件中对应的XCSourceEditorCommandName、XCSourceEditorCommandIdentifier和XCSourceEditorCommandClassName信息。
    /*
    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
        // If your extension needs to return a collection of command definitions that differs from those in its Info.plist, implement this optional property getter.
        return []
    }
    */
    
}
