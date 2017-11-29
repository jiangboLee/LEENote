# LEENote
### 注释小插件
在Xcode8.0以上，xcode提供了`Xcode Source Editor Extension`来开发插件。
![Xcode Source Editor Extension.png](http://upload-images.jianshu.io/upload_images/2868618-0d040f186ff15219.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

Xcode中多行注释可以command + / 来注释代码
```swift
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
```
由于不太喜欢每一行前面都`//`这样显得这个页面比较乱。像整个代码块还是使用多行注释`/***/`，这样看起来比较简洁。
```swift
/** 2017-11-29 16:06:16
    override func viewDidLoad() {
        super.viewDidLoad()

    }
*/
```
所以决定自己开发有一个小插件咯。先直接填代码：
```swift
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
                if end == start {
                    break
                }
                start += 1
                startStr = buffer.lines[start] as! String
            }
        }
        //如果是已经注释的就去掉注释
        if  startStr.hasPrefix("/**") && endStr.hasPrefix("*/") {
            buffer.lines.removeObject(at: end)
            buffer.lines.removeObject(at: start)
            completionHandler(nil)
            return
        }
        //自己多增加了个注释时间
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "zh_CN") as Locale!
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let str = dateFormatter.string(from: NSDate() as Date)
        //代码块前后添加注释字符
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
```
##### 下载后打开文件夹
![leenote.png](http://upload-images.jianshu.io/upload_images/2868618-d15f6358f53c7c35.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
##### 将LeeNote拖到应用程序
![双击.png](http://upload-images.jianshu.io/upload_images/2868618-03cdd4a1a08bbad4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
##### 在个人设置中扩展，将LeeNote插件打钩
![打钩.png](http://upload-images.jianshu.io/upload_images/2868618-d5bf188ba63f13f0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
##### 然后打开Xcode,设置快捷键。接下来重启下Xcode.ok~
![快捷键.png](http://upload-images.jianshu.io/upload_images/2868618-8f3c101e821c0828.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
##### 使用很简单咯
选个代码块，按下快捷键
```swift
/** 2017-11-29 16:20:02
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager *locationManager;
*/
```

