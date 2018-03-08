//
//  UIImage+Insets.m
//  uDay
//
//  Created by Andriko on 2/6/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import "UIImage+Insets.h"

@implementation UIImage (Insets)
+ (UIImage *)imageWithSize: (CGSize)size image:(UIImage *)image {
    CGFloat width = size.width;
    CGFloat height = size.height;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);

    // Now we can draw anything we want into this new context.
    CGPoint origin = CGPointMake((width - image.size.width) / 2.0f,
                                 (height - image.size.height) / 2.0f);
    [image drawAtPoint:origin];

    // Clean up and get the new image.
    UIGraphicsPopContext();
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

+ (UIImage *)imageWithSize: (CGSize)size scaled: (CGSize)scale image:(UIImage *)image {
    CGFloat width = size.width*scale.width;
    CGFloat height = size.height*scale.height;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);

    // Now we can draw anything we want into this new context.
    CGPoint origin = CGPointMake((width - image.size.width) / 2.0f,
                                 (height - image.size.height) / 2.0f);
    [image drawAtPoint:origin];

    // Clean up and get the new image.
    UIGraphicsPopContext();
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;

}
@end
