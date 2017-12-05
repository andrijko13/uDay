//
//  FirstViewController.m
//  uDay
//
//  Created by Andriko on 12/2/17.
//  Copyright © 2017 Andriko. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize navigationBar = _navigationBar;
@synthesize tableView;

- (void)style {
    [self setStatusBarColor: BarGrayTranslucent];
    [self.view setBackgroundColor: [[Styler main] colorForKey:BarGray]];
    
    [[self navigationBar] setTranslucent:false];
    [[self navigationBar] setBarTintColor:[[Styler main] colorForKey:BarGrayTranslucent]];
    [[self navigationBar] setTintColor:[[Styler main] colorForKey:White]];
    //[[self navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
}

- (void)viewDidLoad {
    
    [self style];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
