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
@synthesize tableView;

- (void)style {
    [self.view setBackgroundColor: [[Styler main] colorForKey:BarGrayTranslucent]];
    [self.tableView setBackgroundColor: [[Styler main] colorForKey: DarkGray]];
}

- (void)viewDidLoad {
    
    [self style];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [tableView setAllowsSelection: false];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[DataStore main] fetchEntries] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoalCell"];
    if (cell == nil) {
        cell = [[GoalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoalCell"];
    }
    [cell newSetup];


    RLMResults<Entry *>* results = [[DataStore main] fetchEntries];
    Entry *entry = [results objectAtIndex:indexPath.row];
    Entry *before = NULL;
    if (indexPath.row > 0) {
        before = [results objectAtIndex:(indexPath.row-1)];
    }

    if (entry) {
        [cell setEntry:entry afterGoal:(before ? before.isGoal : false)];
    }

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
