//
//  ThirdViewController.h
//  uDay
//
//  Created by Andriko on 12/2/17.
//  Copyright © 2017 Andriko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UIViewController+Styler.h"
#import "Entry.h"
#import "DataStore.h"
#import "CustomAnnotation.h"
#import "ViewEntryViewController.h"

@interface ThirdViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *mapViewContainer;
@property  MKMapView *mapView;
@end
