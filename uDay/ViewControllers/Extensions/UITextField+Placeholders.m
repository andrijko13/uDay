//
//  UITextField+Placeholders.m
//  uDay
//
//  Created by Andriko on 1/29/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import "UITextField+Placeholders.h"

@implementation UITextField (Placeholders)
-(void)setPlaceholderColor:(Color)color withText:(NSString *)text {
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName: [[Styler main] colorForKey:color]}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }
}
@end
