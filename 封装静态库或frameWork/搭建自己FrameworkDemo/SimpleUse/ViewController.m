//
//  ViewController.m
//  SimpleUse
//
//  Created by HUN on 16/7/24.
//  Copyright © 2016年 hundred Company. All rights reserved.
//

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
