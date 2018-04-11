//
//  Styler.h
//  uDay
//
//  Created by Andriko on 12/2/17.
//  Copyright © 2017 Andriko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Styler : NSObject{
    
}
+ (id)main;

// colors
typedef enum {
    LightBlue,
    LightOrange,
    DarkBlue,
    LightGreen,
    Black,
    LightGray,
    DarkGray,
    White,
    LightWhite,
    BarGray,
    BarGrayTranslucent,
    EditableBackgroundGray,
    LightRed,
    Clear,
} Color;

- (UIColor *)colorForKey:(Color)color;
- (UIColor *)colorForKey:(Color)color alpha:(CGFloat)alpha;

@end
