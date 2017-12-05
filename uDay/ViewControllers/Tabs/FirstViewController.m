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
    [self.tableView setBackgroundColor: [[Styler main] colorForKey: DarkGray]];
    
    [[self navigationBar] setTranslucent: false];
    [[self navigationBar] setBarTintColor:[[Styler main] colorForKey:BarGrayTranslucent]];
    [[self navigationBar] setTintColor:[[Styler main] colorForKey:White]];
    //[[self navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
}

- (void)viewDidLoad {
    
    [self style];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [tableView setAllowsSelection: false];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoalCell"];
    if (cell == nil) {
        cell = [[GoalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoalCell"];
    }
    [cell newSetup];
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // selected row
    [tableView deselectRowAtIndexPath:indexPath animated:false];
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
