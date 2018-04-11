//
//  FirstViewController.m
//  uDay
//
//  Created by Andriko on 12/2/17.
//  Copyright © 2017 Andriko. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
{
    NSInteger selectedIndex;
}
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
    [tableView setAllowsSelection: true];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [tableView reloadData];
    self.navigationController.navigationBar.prefersLargeTitles = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[DataStore main] fetchEntries] count];
}

- (BOOL)isDay:(NSDate*)date1 laterThanDay:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];

    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];

    if ([comp1 year] > [comp2 year]) {
        return true;
    }
    if ([comp2 year] > [comp1 year]) {
        return false;
    }
    if ([comp1 month] > [comp2 month]) {
        return true;
    }
    if ([comp2 month] > [comp1 month]) {
        return false;
    }
    if ([comp1 day] > [comp2 day]) {
        return true;
    }
    return false;
}

-(int)typeForEntry:(Entry *)entry {
    if (!entry) {
        return 0;
    }
    if (entry.complete) {
        return 1;
    }
    if (entry.setDate) {
        if ([self isDay:[NSDate date] laterThanDay:entry.setDate]) {
            return 2;
        }
    }

    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoalCell"];
    if (cell == nil) {
        cell = [[GoalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoalCell"];
    }
    [cell newSetup];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    RLMResults<Entry *>* results = [[DataStore main] fetchEntries];
    Entry *entry = [results objectAtIndex:indexPath.row];
    Entry *before = NULL;
    if (indexPath.row > 0) {
        before = [results objectAtIndex:(indexPath.row-1)];
    }

    if (entry) {
        [cell setEntry:entry afterGoal:(before ? before.isGoal : false) afterType:[self typeForEntry:before]];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIContextualAction *editActions = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Done" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)){
       [[DataStore main] write:^{
           Entry *e = [[[DataStore main] fetchEntries] objectAtIndex:indexPath.row];
           [e setComplete:true];
       }];
        [tableView reloadData];
    }];
    [editActions setBackgroundColor:[[Styler main] colorForKey:LightBlue]];
    return [UISwipeActionsConfiguration configurationWithActions:[NSArray arrayWithObject:editActions]];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[DataStore main] removeEntry:[[[DataStore main] fetchEntries] objectAtIndex:indexPath.row]];
    }

    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // selected row
    [tableView deselectRowAtIndexPath:indexPath animated:false];

    selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"detailSegue" sender:self];

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"] && [segue destinationViewController].class == [ViewEntryViewController class]) {
        ViewEntryViewController *vc = [segue destinationViewController];

        vc.context = [[[DataStore main] fetchEntries] objectAtIndex:selectedIndex];
    }
}

@end
