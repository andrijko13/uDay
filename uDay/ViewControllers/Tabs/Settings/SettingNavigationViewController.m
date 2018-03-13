//
//  SettingNavigationViewController.m
//  uDay
//
//  Created by Andriko on 3/8/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import "SettingNavigationViewController.h"

@interface SettingNavigationViewController ()

@end

@implementation SettingNavigationViewController
@synthesize navBar;

- (void)viewDidLoad {
    [self style];
    [self.navBar setPrefersLargeTitles:true];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)style {
    [[self navBar] setTranslucent: false];
    [[self navBar] setBarTintColor:[[Styler main] colorForKey:BarGrayTranslucent]];
    [[self navBar] setTintColor:[[Styler main] colorForKey:White]];
    [self.view setBackgroundColor: [[Styler main] colorForKey:DarkGray]];

    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
