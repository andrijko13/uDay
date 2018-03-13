//
//  SettingTableViewCell.h
//  uDay
//
//  Created by Andriko on 3/8/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Styler.h"

@interface SettingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet  UISwitch* slider;
@property (weak, nonatomic) IBOutlet UILabel *title;
@end
