# 自己创建一个属于自己的frameWork

更新时间:7-22

---

###前言
之前有很多的大神们已经写过framework的制作，但最近由于Xcode7的出现，很多之前的教程内容已经不符，对于初学者来说，找到一篇能够直接明了，简单易学的制作framework的文章比较困难。本文将基于Xcode7创建一个简单的工程，通过两种方法来教大家如何制作一个自己的framework。

---

###简介
Mac OS X扩展了framework的功能，让我们能够利用它来共享代码和资源。通过framework我们可以共享所有形式的资源，如动态共享库，nib文件，图像字符资源以及文档等。
系统会在需要的时候将framework载入内存中，多个应用程序可以同时使用同一个framework。这种方法可以使得你的代码易分享，在多个工程中复用，并且可以隐藏实现细节，控制公开的头文件。

---

###制作流程

>创建一个frameWork的新工程

![创建Cocoa Touch Framework新工程](http://upload-images.jianshu.io/upload_images/1730495-8a66eb6e88fdb0f3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

>1、在这个工程上，创建一个类,"saySomeThing"

（懒人可以用command+option+↑/↓切换.h或者.m）
saySomeThing.h
```
#import <Foundation/Foundation.h>
 @interface saySomeThing : NSObject 

-(void)sayHello; 

@end
```
saySomeThing.m
```
#import "saySomeThing.h"
 @implementation saySomeThing 
-(void)sayHello 
{
 NSLog(@"这是我的微信：whundred,有兴趣一起实现分享知识的一起学习交流"); 
}
 @end
```

![创建一个叫saySomething类继承NSObject](http://upload-images.jianshu.io/upload_images/1730495-9e48780d109b70ad.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

---
>2、配置

A、配置target的文件
![这次教程的配置](http://upload-images.jianshu.io/upload_images/1730495-0e52fcbc3752b6c1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![选项部分,具体可以根据自己需求选Mach-O type](http://upload-images.jianshu.io/upload_images/1730495-ee42d7f46ad95917.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

B、配置在Architectures下增加armv7s，并选中。将Build Active Architecture Only 设置为NO。


![添加armv7s](http://upload-images.jianshu.io/upload_images/1730495-975488a03d51028c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

---
C、设置Headers
将你要公开的头文件移动到Public下，要隐藏的放在Private或者Project下，当然，隐藏的头文件就无法再被引用。和类的属性一致，比较简单的理解


![添加头方法](http://upload-images.jianshu.io/upload_images/1730495-7ef9a5087b762673.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![最终demo的头状态](http://upload-images.jianshu.io/upload_images/1730495-4210e0e51e9c39ee.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

然后需要在helloHundred.h（必须是公开的，否则无法引用）中将你所有要公开的.h引入。


![helloHundred.h中添加saySomeThing.h](http://upload-images.jianshu.io/upload_images/1730495-aa79ed50be11882b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

---
>3.恭喜你，离成功不远了，打包framework

先来科普一下
>因为我们需要制作的是静态库，并且苹果不让包含有自己制作的动态库的项目上线，所以需要我们自己手动设置为静态库。

静态库简介：

>在企业开发中，一些核心技术或者常用框架，出于安全性和稳定性的考虑，不想被外界知道，所以会把核心代码打包成静态库，只暴露头文件给程序员使用（比如：友盟、百度地图等第三方的sdk）

存在形式

>静态库：.a 和 .framework
动态库：.dylib 和 .framework

区别：

>静态库：链接时，静态库会被完整地复制到可执行文件中，被多次使用就有多份冗余拷贝
动态库：链接时不复制，程序运行时由系统动态加载到内存，供程序调用，系统只加载一次，多个程序共用，节省内存

版本：

>真机-Debug版本
真机-Release版本
模拟器-Debug版本
模拟器-Release版本

Debug(调试)版本
>1.含完整的符号信息，以方便调试
2.不会对代码进行优化

Release(发布)版本
>1.不会包含完整的符号信息
2.的执行代码是进行过优化的
3.的大小会比Debug版本的略小
4.在执行速度方面，Release版本会更快些（但不意味着会有显著的提升）


---
####创建方法一
*1.选中模拟器，编译程序*
*2.选中测试机，编译程序*
*3.在finder中找到framework文件* **(确保前两步都成功！)**准备合并


![打开文件夹](http://upload-images.jianshu.io/upload_images/1730495-c32ce787b3446a39.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![这是真机和调试的文件](http://upload-images.jianshu.io/upload_images/1730495-93f21ae6a707867a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

合并
```
1、打开终端，输入cd，然后把products文件拖进终端，enter
2、这里我为了可以看分成了4段
lipo -create 
/Users/huanghuiqun/Library/Developer/Xcode/DerivedData/helloHundred-hjhmghxpoacbrbdttgjgytnfgcov/Build/Products/Debug-iphoneos/helloHundred.framework/helloHundred 
/Users/huanghuiqun/Library/Developer/Xcode/DerivedData/helloHundred-hjhmghxpoacbrbdttgjgytnfgcov/Build/Products/Debug-iphonesimulator/helloHundred.framework/helloHundred 
-output helloHundred
MacBook-Pro:Desktop huanghuiqun$ 
3、在Products目录下生成了MyTestFramework文件，然后分别到真机和模拟器的版本下替换掉。

```
特别说明一下:
######**合并的命令说明：**
######****lipo -create 文件1的路径 文件2的路径 -output 合并之后的文件路径（没有表示在当前目录下） 合并之后的文件名称****
######每一个参数之间都应该至少留出一个空格**

![图示部分](http://upload-images.jianshu.io/upload_images/1730495-a4d3ee3bdb223f83.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

最后只要吧编译出来的放回去原来的调试和真机中就可以了，替换掉就完事，开开心心把库拿去用吧～记得去library导入库!s

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/1730495-05bba97878fe7ef0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

---
#####注意方法1中出现编译时候的问题
这里出现一个问题，可以参考以下文献这是问题：
解决方法：[参考文章，我这里用了第4个方法](http://www.th7.cn/Program/IOS/201503/406525.shtml)
```
** Build settings->Linking->Other Linker Flags将此属性修改成-all_load  或者 -ObjC **
```
![错误提示:Needed to perform lazy binding to function _NSLog for architecture i386](http://upload-images.jianshu.io/upload_images/1730495-94a254488eecb8cb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![示范操作](http://upload-images.jianshu.io/upload_images/1730495-be210e8b5476091a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

---
###使用自己弄的FrameWork
1、导入库(不懂的朋友可以百度，我给大家献上一张图，库记得放在工程文件内才导入哈)

![文件目录](http://upload-images.jianshu.io/upload_images/1730495-e3517bd4c58cfe6c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![添加框架](http://upload-images.jianshu.io/upload_images/1730495-5c58887fabacec75.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2、导入库头文件，直接调用
```
#import "ViewController.h"
#import <showTest/showTest.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)show:(id)sender
{
    [[myExample new] saySome];
}

@end
```
![调试成功](http://upload-images.jianshu.io/upload_images/1730495-e01d006eb524daea.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这个是demo以及这个案例中用到的frameWork可以下载来自己参考参考
[githubDemo](https://github.com/OneHundredSir/-FrameWorkShow)
喜欢的朋友可以赏我2块大洋买糖吃～和我一样屌丝的朋友希望能给我点个赞～需要我录制视频的请直接给我糖。一起做一个乐于分享的人吧.
