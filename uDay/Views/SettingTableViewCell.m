//
//  SettingTableViewCell.m
//  uDay
//
//  Created by Andriko on 3/8/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell
@synthesize slider;
@synthesize title;

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.slider setOn:true animated:true];
    [self setBackgroundColor:[[Styler main] colorForKey:DarkGray]];
    [self.slider setOnTintColor:[[Styler main] colorForKey:LightBlue]];
    [self.slider setTintColor:[[Styler main] colorForKey:LightBlue]];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
