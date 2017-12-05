//
//  FirstViewController.h
//  uDay
//
//  Created by Andriko on 12/2/17.
//  Copyright © 2017 Andriko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Styler.h"

@interface FirstViewController : UIViewController {
    NSMutableArray *goals;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

