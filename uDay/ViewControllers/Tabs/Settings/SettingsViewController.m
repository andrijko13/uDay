//
//  SettingsViewController.m
//  uDay
//
//  Created by Andriko on 3/8/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
{
    NSMutableArray *settings;
}
@end

@implementation SettingsViewController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:[NSBundle bundleForClass:self.class]] forCellReuseIdentifier:@"settingCell"];
    [tableView registerNib:[UINib nibWithNibName:@"SettingDeleteCell" bundle:[NSBundle bundleForClass:self.class]] forCellReuseIdentifier:@"deleteCell"];
    [tableView setTableFooterView: [[UIView alloc] initWithFrame:CGRectZero]];
    tableView.allowsSelection = false;

    [self fetchData];
    [tableView reloadData];

    [self style];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// to fetch custom settings
-(void)fetchData {
    settings = @[@"Low Battery Usage", @"Offline Sync", @"Assistive Mode", @"Auto-Refresh Map", @"Persist Settings"];
}

// MARK: - Helpers
-(void) style {
    [self.view setBackgroundColor: [[Styler main] colorForKey:BarGrayTranslucent]];
    [self.tableView setBackgroundColor: [[Styler main] colorForKey: DarkGray]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return settings.count + 1;
}

-(SettingTableViewCell *) makeSettingCellWithTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell" forIndexPath:indexPath];
    cell.title.text = settings[indexPath.row];
    [cell setBackgroundColor:indexPath.row % 2 == 0 ? [[Styler main] colorForKey:DarkGray] : [[Styler main] colorForKey:BarGrayTranslucent]];
    return cell;
}

-(SettingDeleteTableViewCell *) makeDeleteCellWithTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath {
    SettingDeleteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deleteCell" forIndexPath:indexPath];
    [cell.button setTitle:title forState:UIControlStateNormal];
    cell.deleteBlock = ^{
        [[DataStore main] removeAllEntries];
    };
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < settings.count) {
        return [self makeSettingCellWithTitle:[settings objectAtIndex:indexPath.row] indexPath:indexPath];
    } else {
        return [self makeDeleteCellWithTitle:@"Delete All Entries" indexPath:indexPath];
    }
}

@end
