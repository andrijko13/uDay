//
//  TImelineEntryController.m
//  uDay
//
//  Created by Andriko on 1/30/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import "TImelineEntryController.h"

@interface TImelineEntryController ()

@end

@implementation TImelineEntryController

- (void)viewDidLoad {
    [self style];
    [self.navigationBar setPrefersLargeTitles:true];
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


/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
