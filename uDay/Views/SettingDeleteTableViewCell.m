//
//  SettingDeleteTableViewCell.m
//  uDay
//
//  Created by Andriko on 3/8/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import "SettingDeleteTableViewCell.h"

@implementation SettingDeleteTableViewCell
@synthesize button;
@synthesize deleteBlock;

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBackgroundColor:[[Styler main] colorForKey:Clear]];
    [self.button.layer setCornerRadius:7.5f];
    [self.separator setBackgroundColor:[[Styler main] colorForKey:BarGrayTranslucent]];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)buttonTapped:(id)sender {
    if (deleteBlock) {
        deleteBlock();
    }
}

@end
