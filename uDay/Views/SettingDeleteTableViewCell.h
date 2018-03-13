//
//  SettingDeleteTableViewCell.h
//  uDay
//
//  Created by Andriko on 3/8/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Styler.h"

typedef void (^DeleteActionBlock)(void);
@interface SettingDeleteTableViewCell : UITableViewCell
{
}
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *separator;
@property (nonatomic, copy) DeleteActionBlock deleteBlock;
- (IBAction)buttonTapped:(id)sender;
@end
