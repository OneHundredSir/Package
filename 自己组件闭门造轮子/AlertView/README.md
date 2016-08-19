>###封装的效果图

![效果图](http://upload-images.jianshu.io/upload_images/1730495-3a6e09448e13b0f4.gif?imageMogr2/auto-orient/strip)

>###具体实现

```
//让弹窗出现

+ (void) addHNotifierWithText : (NSString* ) text dismissAutomatically : (BOOL) shouldDismiss {
    //get screen area
    CGRect screenBounds = APPDELEGATE.window.bounds;
    
    //get width for given text
    NSDictionary *attributeDict = @{NSFontAttributeName : NOTIFIER_LABEL_FONT};
    CGFloat height = kLabelHeight;
    CGFloat width = CGFLOAT_MAX;
    CGRect notifierRect = [text boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDict context:NULL];
    
    //get xoffset width for the notifier view
    CGFloat notifierWidth = MIN(CGRectGetWidth(notifierRect) + 2*xPadding, kMaxWidth);
    CGFloat xOffset = (CGRectGetWidth(screenBounds) - notifierWidth)/2;
    
    //get height for notifier view.. Add cancel button height if not dismissing automatically
    NSInteger notifierHeight = kLabelHeight;
    if(!shouldDismiss) {
        notifierHeight += (kCancelButtonHeight+kSeparatorHeight);
    }
    
    //get yOffset for notifier view
    CGFloat yOffset = CGRectGetHeight(screenBounds) - notifierHeight - kHeightFromBottom;
    
    CGRect finalFrame = CGRectMake(xOffset, yOffset, notifierWidth, notifierHeight);
    
    UIView* notifierView = [self checkIfNotifierExistsAlready];
    if(notifierView) {
        //update the existing notification here
        [self updateNotifierWithAnimation:notifierView withText:text completion:^(BOOL finished) {
            CGRect atLastFrame = finalFrame;
            atLastFrame.origin.y = finalFrame.origin.y + 8;
            notifierView.frame = atLastFrame;
            
            //get the label and update its text and frame!
            UILabel* textLabel = nil;
            for (UIView* subview in notifierView.subviews) {
                if([subview isKindOfClass:[UILabel class]]) {
                    textLabel = (UILabel* ) subview;
                }
                
                //also remove separator and "cancel" button.. we may add it later if necessary
                if([subview isKindOfClass:[UIImageView class]] || [subview isKindOfClass:[UIButton class]]) {
                    [subview removeFromSuperview];
                }
            }
            textLabel.text = text;
            textLabel.frame = CGRectMake(xPadding, 0.0, notifierWidth - 2*xPadding, kLabelHeight);
            
            //if not dismissing
            if(!shouldDismiss) {
                //first show a separator
                UIImageView* separatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, CGRectGetHeight(textLabel.frame), CGRectGetWidth(notifierView.frame), kSeparatorHeight)];
                [separatorImageView setBackgroundColor:UIColorFromRGB(0xF94137)];
                [notifierView addSubview:separatorImageView];
                
                //now add that cancel button
                UIButton* buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
                buttonCancel.frame = CGRectMake(0.0, CGRectGetMaxY(separatorImageView.frame), CGRectGetWidth(notifierView.frame), kCancelButtonHeight);
                [buttonCancel setBackgroundColor:UIColorFromRGB(0x000000)];
                [buttonCancel addTarget:self action:@selector(buttonCancelClicked:) forControlEvents:UIControlEventTouchUpInside];
                [buttonCancel setTitle:@"Cancel" forState:UIControlStateNormal];
                buttonCancel.titleLabel.font = NOTIFIER_CANCEL_FONT;
                [notifierView addSubview:buttonCancel];
            }
            
            [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                notifierView.alpha = 1;
                notifierView.frame = finalFrame;
            } completion:^(BOOL finished) {
            }];
        }];
        
        if(shouldDismiss) {
            [self performSelector:@selector(dismissHNotifier) withObject:nil afterDelay:2.0];
        }
    }
    else {
        notifierView = [[UIView alloc] initWithFrame:CGRectMake(xOffset, CGRectGetHeight(screenBounds), notifierWidth, notifierHeight)];
        notifierView.backgroundColor = UIColorFromRGB(0xF94137);
        notifierView.tag = kTagHAlertView;
        notifierView.clipsToBounds = YES;
        notifierView.layer.cornerRadius = 5.0;
        [APPDELEGATE.window addSubview:notifierView];
        [APPDELEGATE.window bringSubviewToFront:notifierView];
        
        //create label which holds text inside the notifier view
        UILabel* textLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPadding, 0.0, notifierWidth - 2*xPadding, kLabelHeight)];
        textLabel.adjustsFontSizeToFitWidth = YES;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = UIColorFromRGB(0xFFFFFF);
        textLabel.font = NOTIFIER_LABEL_FONT;
        textLabel.minimumScaleFactor = 0.7;
        textLabel.text = text;
        [notifierView addSubview:textLabel];
        
        if(shouldDismiss) {
            [self performSelector:@selector(dismissHNotifier) withObject:nil afterDelay:2.0];
        }
        else {
            //not dismissng automatically... show cancel button to dismiss this alert
            
            //first show a separator
            UIImageView* separatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, CGRectGetHeight(textLabel.frame), notifierWidth, kSeparatorHeight)];
            [separatorImageView setBackgroundColor:UIColorFromRGB(0xF94137)];
            [notifierView addSubview:separatorImageView];
            
            //now add that cancel button
            UIButton* buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonCancel.frame = CGRectMake(0.0, CGRectGetMaxY(separatorImageView.frame), notifierWidth, kCancelButtonHeight);
            [buttonCancel setBackgroundColor:UIColorFromRGB(0x000000)];
            [buttonCancel addTarget:self action:@selector(buttonCancelClicked:) forControlEvents:UIControlEventTouchUpInside];
            [buttonCancel setTitle:@"Cancel" forState:UIControlStateNormal];
            buttonCancel.titleLabel.font = NOTIFIER_CANCEL_FONT;
            [notifierView addSubview:buttonCancel];
        }
        
        [self startEntryAnimation:notifierView withFinalFrame:finalFrame];
    }
}
```

```
//让弹窗消失

+ (void) dismissHNotifier {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissHNotifier) object:nil];
    
    UIView* notifier = nil;
    
    for (UIView* subview in [APPDELEGATE.window subviews]) {
        if(subview.tag == kTagHAlertView && [subview isKindOfClass:[UIView class]]) {
            notifier = subview;
        }
    }
    
    [self startExitAnimation:notifier];
}
```


>###demo下载

Demo/封装的分类连接：[提示框封装源码](https://github.com/OneHundredSir/packaging/tree/AlertView)


>作者信息

如果有不足或者错误的地方还望各位读者批评指正，可以评论留言，笔者收到后第一时间回复。

|名称|具体信息|
|:--:|:--:|
|QQ/微信|hundreda |
|简书号连接|[iOS-香蕉大大](http://www.jianshu.com/users/a3ae6d7c68b6/latest_articles)|
|GitHub个人开源主页|[GitHub连接](https://github.com/OneHundredSir)|
|好心人赏我个`赞`|`欢迎各位前来查看，star,感谢各位的阅读`|
|个人iOS开发QQ讨论群|**365204530**|
|`群内规矩`|`聊天扯淡，讨论技术都行，没有什么群规，不懂就问`|
|iOS开发类微信订阅号|**大大家的IOS说**|
|*微信扫一扫下面二维码* |`一起用碎片时间学习IOS吧`|


![微信个人技术订阅号](http://upload-images.jianshu.io/upload_images/1730495-755d908f00d77cf8.gif?imageMogr2/auto-orient/strip)
喜欢的朋友可以赏我2块大洋买糖吃～你的打赏是我前进的动力~一起做一个乐于分享的人吧~