//
//  CustomAnnotation.h
//  uDay
//
//  Created by Andriko on 4/11/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Entry.h"
#import "Styler.h"

@interface CustomAnnotation : MKPointAnnotation
@property Entry *context;
@property Color color;
@end
