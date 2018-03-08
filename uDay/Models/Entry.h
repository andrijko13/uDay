//
//  Entry.h
//  uDay
//
//  Created by Andriko on 2/8/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "RLMImage.h"
#import "RLMLocation.h"

RLM_ARRAY_TYPE(Entry)
RLM_ARRAY_TYPE(RLMImage)

@interface Entry : RLMObject
{
}
@property BOOL isGoal;
@property BOOL complete;
@property NSDate *endDate;
@property NSDate *setDate;
@property NSString *title;
@property NSString *description;
@property RLMArray<RLMImage *><RLMImage> *images;
@property RLMLocation *location;
@end
