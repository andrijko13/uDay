//
//  UIViewController+Styler.m
//  uDay
//
//  Created by Andriko on 12/2/17.
//  Copyright © 2017 Andriko. All rights reserved.
//

#import "UIViewController+Styler.h"

@implementation UIViewController (Styler)
-(void)setStatusBarColor:(Color)color {
    UIApplication *app = [UIApplication sharedApplication];
    CGFloat statusBarHeight = app.statusBarFrame.size.height;
    
    UIView *statusBarView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, statusBarHeight)];
    statusBarView.backgroundColor  =  [[Styler main] colorForKey:color];
    [self.view addSubview:statusBarView];
}
@end
