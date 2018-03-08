//
//  GoalTableViewCell.h
//  uDay
//
//  Created by Andriko on 12/5/17.
//  Copyright © 2017 Andriko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Styler.h"
#import "Entry.h"

@interface GoalTableViewCell : UITableViewCell
{
    BOOL isAfterGoal;
}
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *timelineLine;
@property (weak, nonatomic) IBOutlet UILabel *body;
@property (weak, nonatomic) IBOutlet UILabel *tagText;
@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet UIImageView *timelineImageView;
@property (weak, nonatomic) Entry *entry;

-(void)setEntry:(Entry *)entry afterGoal: (BOOL)afterGoal;
-(void)newSetup;
@end
