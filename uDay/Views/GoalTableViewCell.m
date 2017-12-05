//
//  GoalTableViewCell.m
//  uDay
//
//  Created by Andriko on 12/5/17.
//  Copyright © 2017 Andriko. All rights reserved.
//

#import "GoalTableViewCell.h"

@interface GoalTableViewCell()
{
    
}
@end

@implementation GoalTableViewCell
@synthesize title;
@synthesize timelineLine;
@synthesize timelineImageView;
@synthesize body;
@synthesize tagText;
@synthesize tagView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)newSetup {
    [title setText:@"Title"];
    [title setTextColor:[[Styler main] colorForKey:White]];
    [body setText:@"This will be a very long body to show what a very long string will look like inside a multiline label. This will be a very long body to show what a very long string will look like inside a multiline label. This will be a very long body to show what a very long string will look like inside a multiline label."];
    [body setTextColor:[[Styler main] colorForKey:White]];
    [timelineLine setBackgroundColor:[[Styler main] colorForKey:LightBlue]];
    [timelineImageView setBackgroundColor:[[Styler main] colorForKey:LightBlue]];
    [timelineImageView setClipsToBounds:true];
    [timelineImageView.layer setCornerRadius: timelineImageView.frame.size.width/2];
    [timelineImageView.layer setBorderColor:[[Styler main] colorForKey:Black].CGColor];
    [timelineImageView.layer setBorderWidth:1.0f];
    [tagView setBackgroundColor:[UIColor greenColor]];
    [tagView.layer setCornerRadius:4];
    [tagText setText:@"Done"];
    [self setBackgroundColor:[[Styler main] colorForKey:DarkGray]];
}

@end
