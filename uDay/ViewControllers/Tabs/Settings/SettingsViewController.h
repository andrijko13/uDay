//
//  SettingsViewController.h
//  uDay
//
//  Created by Andriko on 3/8/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Styler.h"
#import "SettingTableViewCell.h"
#import "SettingDeleteTableViewCell.h"
#import "DataStore.h"

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
