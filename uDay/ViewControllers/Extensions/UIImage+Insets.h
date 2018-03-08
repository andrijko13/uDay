//
//  UIImage+Insets.h
//  uDay
//
//  Created by Andriko on 2/6/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (Insets)
+ (UIImage *)imageWithSize: (CGSize)size image:(UIImage *)image;
+ (UIImage *)imageWithSize: (CGSize)size scaled: (CGSize)scale image:(UIImage *)image;
@end
