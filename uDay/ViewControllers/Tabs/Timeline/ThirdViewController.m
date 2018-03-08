//
//  ThirdViewController.m
//  uDay
//
//  Created by Andriko on 12/2/17.
//  Copyright © 2017 Andriko. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()
{
}
@end

@implementation ThirdViewController
@synthesize mapView;
@synthesize mapViewContainer;

-  (void)style {
    [self.view setBackgroundColor: [[Styler main] colorForKey:DarkGray]];
}

- (void)viewDidLoad {
    [self style];
    [super viewDidLoad];

    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, mapViewContainer.frame.size.width, mapViewContainer.frame.size.height)];
    [mapView setMapType:MKMapTypeStandard];
    [mapView setShowsScale:true];
    [mapView setShowsCompass:true];
    [mapView setShowsUserLocation:true];
    [mapView setShowsPointsOfInterest:true];
    
    [self.mapViewContainer addSubview: mapView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
}

@end
