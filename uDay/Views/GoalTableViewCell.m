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
    CALayer *lineGradient;
}
@end

@implementation GoalTableViewCell
@synthesize title;
@synthesize timelineLine;
@synthesize timelineImageView;
@synthesize body;
@synthesize tagText;
@synthesize tagView;
@synthesize entry = _entry;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (BOOL)isDay:(NSDate*)date1 laterThanDay:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];

    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];

    if ([comp1 year] > [comp2 year]) {
        return true;
    }
    if ([comp1 month] > [comp2 month]) {
        return true;
    }
    if ([comp1 day] > [comp2 day]) {
        return true;
    }
    return false;
}


-(void)setEntry:(Entry *)entry afterGoal: (BOOL)afterGoal {
    _entry = entry;
    isAfterGoal = afterGoal;
    [self style];
}

-(Entry *)entry {
    return _entry;
}

-(void) style {
    if (_entry.isGoal) { //// ----------> GOAL
        [tagView setBackgroundColor:[[Styler main] colorForKey:LightOrange]];
        [timelineImageView setBackgroundColor:[[Styler main] colorForKey:LightOrange]];
        if (_entry.complete) {
            [tagView setBackgroundColor:[UIColor greenColor]];
        } else if (_entry.setDate) {
            if ([self isDay:[NSDate date] laterThanDay:_entry.setDate]) {
                [tagView setBackgroundColor:[[Styler main] colorForKey:LightRed]];
            } else {
                [tagView setBackgroundColor:[[Styler main] colorForKey:LightOrange]];
            }
        }

        if (_entry.setDate) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [dateFormatter setDateFormat:@"MM'/'dd'/'yyyy"];
            NSString *formattedDate = (_entry.endDate) ? [dateFormatter stringFromDate:_entry.endDate] : [dateFormatter stringFromDate:_entry.setDate];
            [self.tagText setText:[NSString stringWithFormat:@"%@",formattedDate]];
        } else {
            [self.tagText setText:@"∞"];
        }
    } else { //// -------------> Entry
        [tagView setBackgroundColor:[[Styler main] colorForKey:LightBlue]];
        [timelineImageView setBackgroundColor:[[Styler main] colorForKey:LightBlue]];
        if (_entry.setDate) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [dateFormatter setDateFormat:@"MM'/'dd'/'yyyy"];
            NSString *formattedDate = [dateFormatter stringFromDate:_entry.setDate];
            [self.tagText setText:[NSString stringWithFormat:@"%@",formattedDate]];
        } else {
            [self.tagText setText:[NSString stringWithFormat:@"-"]];
        }
    }

    [title setText:_entry.title];

    if (_entry.description) {
        [body setText:_entry.description];

        NSInteger lineCount = 0;
        CGSize textSize = CGSizeMake(body.frame.size.width, MAXFLOAT);
        long rHeight = lroundf([body sizeThatFits:textSize].height);
        long charSize = lroundf(body.font.lineHeight);
        lineCount = rHeight/charSize;

        NSMutableString *newText = [NSMutableString stringWithString:_entry.description];
        long i = 4 - lineCount;
        while (i-- > 0) {
            [newText appendString:@"\n"];
        }

        [body setText:newText];
    }

    CAGradientLayer *gradient = [CAGradientLayer layer];

    gradient.frame = self.timelineLine.bounds;

    if (isAfterGoal) {
        if (_entry.isGoal) {
            gradient.colors = @[(id)[UIColor orangeColor].CGColor, (id)[UIColor orangeColor].CGColor, (id)[UIColor orangeColor].CGColor, (id)[UIColor orangeColor].CGColor];
        } else {
            gradient.colors = @[(id)[UIColor orangeColor].CGColor, (id)[UIColor blueColor].CGColor, (id)[UIColor blueColor].CGColor, (id)[UIColor blueColor].CGColor];
        }
    } else {
        if (_entry.isGoal) {
            gradient.colors = @[(id)[UIColor blueColor].CGColor, (id)[UIColor orangeColor].CGColor, (id)[UIColor orangeColor].CGColor, (id)[UIColor orangeColor].CGColor];
        } else {
            gradient.colors = @[(id)[UIColor blueColor].CGColor, (id)[UIColor blueColor].CGColor, (id)[UIColor blueColor].CGColor, (id)[UIColor blueColor].CGColor];
        }
    }
    gradient.startPoint = CGPointMake(0.5,0);
    gradient.endPoint = CGPointMake(0.5,1);

    if (lineGradient != nil) {
        [lineGradient removeFromSuperlayer];
    }

    [self.timelineLine.layer insertSublayer:gradient atIndex:0];
    lineGradient  = gradient;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)newSetup {
    //[title setText:@"Title"];
    [title setTextColor:[[Styler main] colorForKey:White]];
    //[body setText:@"This will be a very long body to show what a very long string will look like inside a multiline label. This will be a very long body to show what a very long string will look like inside a multiline label. This will be a very long body to show what a very long string will look like inside a multiline label."];
    [body setTextColor:[[Styler main] colorForKey:White]];
    [timelineLine setBackgroundColor:[[Styler main] colorForKey:LightBlue]];
    [timelineImageView setBackgroundColor:[[Styler main] colorForKey:LightBlue]];
    [timelineImageView setClipsToBounds:true];
    [timelineImageView.layer setCornerRadius: timelineImageView.frame.size.width/2];
    [timelineImageView.layer setBorderColor:[[Styler main] colorForKey:Black].CGColor];
    [timelineImageView.layer setBorderWidth:1.0f];
    [tagView setBackgroundColor:[UIColor greenColor]];
    [tagView.layer setCornerRadius:4];
    //[tagText setText:@"Done"];
    [self setBackgroundColor:[[Styler main] colorForKey:DarkGray]];
}

@end
