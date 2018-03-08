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

@interface ThirdViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *mapViewContainer;
@property  MKMapView *mapView;
@end
