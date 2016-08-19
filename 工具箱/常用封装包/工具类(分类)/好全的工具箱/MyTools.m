//
//  MyTools.m
//  Tool
//
//  Created by whunf on 15/9/17.
//  Copyright (c) 2015年 whunf. All rights reserved.
//

#import "MyTools.h"

@implementation MyTools
#pragma mark --UIColor 转UIImage
/**
 *  UIColor 转UIImage
 *
 *  @param color <#color description#>
 *
 *  @return <#return value description#>
 */
+(UIImage*)ChangeUIColorToUIImage: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


#pragma mark --UIImage转UIColor
/**
 *  UIImage转UIColor
 *
 *  @param pngName <#pngName description#>
 *
 *  @return <#return value description#>
 */
+(UIColor *)ChangeUIImageToUIColor:(NSString *)pngName{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:pngName]];
}

#pragma mark --UIView转UIImage
/**
 *  UIView转UIImage
 *
 *  @param v <#v description#>
 *
 *  @return <#return value description#>
 */
+(UIImage*)convertViewToImage:(UIView*)v{
    
    //    UIGraphicsBeginImageContext(v.bounds.size);
    //
    //    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    //
    //    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    //
    //    UIGraphicsEndImageContext();
    //
    //    return image;
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark --根据给定的图片，从其指定区域截取一张新的图片
/**
 *  根据给定的图片，从其指定区域截取一张新的图片
 *
 *  @param img <#img description#>
 *
 *  @return <#return value description#>
 */
+(UIImage *)getImageFromImage:(UIImage *)img{
    CGSize imgSize =img.size;
    float minwidthFloat = imgSize.width;
    float minheightFloat = imgSize.height;
    UIImage* smallImage =img;
    //大图bigImage
    //定义myImageRect，截图的区域
    //    CGRect myImageRect;// = CGRectMake(10.0, 10.0, SCREEN_WIDTH,SCREEN_WIDTH);
    //    if (imgSize.width>SCREEN_WIDTH && imgSize.height>SCREEN_WIDTH) {
    //        minwidthFloat = (minwidthFloat-SCREEN_WIDTH)/2;
    //        minheightFloat = (minheightFloat-SCREEN_WIDTH)/2;
    //
    //    }else if (imgSize.width>SCREEN_WIDTH && imgSize.height<=SCREEN_WIDTH){
    //        minwidthFloat = (minwidthFloat-SCREEN_WIDTH)/2;
    //    }else if (imgSize.height>SCREEN_WIDTH && imgSize.width<=SCREEN_WIDTH){
    //        minheightFloat = (minheightFloat-SCREEN_WIDTH)/2;
    //    }else{
    //        return smallImage;
    //    }
    //
    if (minwidthFloat>[UIScreen mainScreen].bounds.size.width) {//320你自定义大小，想要弄多大，就弄多大
        minwidthFloat = [UIScreen mainScreen].bounds.size.width;
        minheightFloat = imgSize.height*minwidthFloat/imgSize.width;
        if (minheightFloat>[UIScreen mainScreen].bounds.size.height) {
            minheightFloat = [UIScreen mainScreen].bounds.size.width;
            minwidthFloat = imgSize.width*minheightFloat/imgSize.height;
        }
    }else{
        return smallImage;
    }
    
    //    myImageRect = CGRectMake(minwidthFloat,minheightFloat, SCREEN_WIDTH,SCREEN_WIDTH);
    //    UIImage* bigImage= smallImage;
    //    CGImageRef imageRef = bigImage.CGImage;
    //    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    //    CGSize size;
    //    size.width = SCREEN_WIDTH;
    //    size.height = SCREEN_WIDTH;
    //    UIGraphicsBeginImageContext(size);
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextDrawImage(context, myImageRect, subImageRef);
    //    smallImage = [UIImage imageWithCGImage:subImageRef];
    //    UIGraphicsEndImageContext();
    smallImage = [self scaleToSize:img size:CGSizeMake(minwidthFloat, minheightFloat)];
    return smallImage;
}

#pragma mark --十六进制转换为普通字符串的。
/**
 *  十六进制转换为普通字符串的。
 *
 *  @param hexString <#hexString description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
}

#pragma mark --普通字符串转换为十六进制的。
/**
 *  普通字符串转换为十六进制的。
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
/**
 *  颜色转换 IOS中十六进制的颜色转换为UIColor
 *
 *  @param color <#color description#>
 *
 *  @return <#return value description#>
 */
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


/**
 *  绘图
 *
 *  @param colorName <#colorName description#>
 *
 *  @return <#return value description#>
 */
+(UIImage *)drawcolorInImage:(NSString *)colorName{
    
    CGRect rect = CGRectMake(0, 0, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,
                                   [[self colorWithHexString:colorName] CGColor]);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage * imge;// = [[UIImage alloc] init];
    imge = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imge;
    
}

#pragma mark --图片缩放到指定大小尺寸
/**
 *  图片缩放到指定大小尺寸
 *
 *  @param img  <#img description#>
 *  @param size <#size description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end
