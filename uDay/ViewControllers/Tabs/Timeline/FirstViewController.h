//
//  FirstViewController.h
//  uDay
//
//  Created by Andriko on 12/2/17.
//  Copyright © 2017 Andriko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Styler.h"
#import "GoalTableViewCell.h"
#import "DataStore.h"
#import "ViewEntryViewController.h"

@interface FirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *goals;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

