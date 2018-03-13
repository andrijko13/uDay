//
//  Styler.m
//  uDay
//
//  Created by Andriko on 12/2/17.
//  Copyright © 2017 Andriko. All rights reserved.
//

#import "Styler.h"

@implementation Styler
+ (id)main {
    static Styler *mainStyler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mainStyler = [[self alloc] init];
    });
    return mainStyler;
}

- (id)init {
    if (self = [super init]) {
        // custom init
    }
    return self;
}

- (UIColor *)colorForKey:(Color)color {
    switch (color) {
        case LightBlue:
            return [UIColor colorWithRed:77.0f/255.0f green:115.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
            break;
        case LightOrange:
            return [UIColor colorWithRed:255.0f/255.0f green:115.0f/255.0f blue:77.0f/255.0f alpha:1.0f];
            break;
        case DarkBlue:
            return [UIColor blueColor];
            break;
        case LightGray:
            return [UIColor lightGrayColor];
            break;
        case DarkGray:
            return [UIColor colorWithRed:55.0f/255.0f green:55.0f/255.0f blue:55.0f/255.0f alpha:1.0f];
            break;
        case Black:
            return [UIColor blackColor];
            break;
        case White:
            return [UIColor whiteColor];
            break;
        case BarGray:
            return [UIColor colorWithRed:21.0f/255.0f green:21.0f/255.0f blue:21.0f/255.0f alpha:1.0f];
            break;
        case BarGrayTranslucent:
            return [UIColor colorWithRed:45.0f/255.0f green:45.0f/255.0f blue:45.0f/255.0f alpha:1.0f];
            break;
        case EditableBackgroundGray:
            return [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
            break;
        case LightRed:
            return [UIColor colorWithRed:255.0f/255.0f green:122.0f/255.0f blue:118.0f/255.0f alpha:1.0f];
            break;
        case Clear:
            return [UIColor clearColor];
            break;
        default:
            return [UIColor clearColor];
            break;
    }
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}
@end
