//
//  AddToMapViewController.h
//  uDay
//
//  Created by Andriko on 2/13/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UIViewController+Styler.h"

@interface AddToMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *mapViewContainer;
@property MKMapView *mapView;
@end
