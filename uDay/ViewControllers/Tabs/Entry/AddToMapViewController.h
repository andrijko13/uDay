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
#import <QuartzCore/QuartzCore.h>
#import "Entry.h"

@protocol AddLocationDelegate
-(void)addLocation:(RLMLocation *)location;
@end

@interface AddToMapViewController : UIViewController <UISearchBarDelegate, CLLocationManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *mapViewContainer;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) id<AddLocationDelegate> delegate;
- (IBAction)addClicked:(id)sender;
@property MKMapView *mapView;

-(void)responseReceived:(MKLocalSearchResponse *)response;
@end
