//
//  AddToMapViewController.m
//  uDay
//
//  Created by Andriko on 2/13/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import "AddToMapViewController.h"

@interface AddToMapViewController ()

@end

@implementation AddToMapViewController
@synthesize mapViewContainer;
@synthesize mapView;

-  (void)style {
    [self.view setBackgroundColor: [[Styler main] colorForKey:DarkGray]];
}

- (void)viewDidLoad {
    [self style];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated {
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, mapViewContainer.frame.size.width, mapViewContainer.frame.size.height)];
    [mapView setMapType:MKMapTypeStandard];
    [mapView setShowsScale:true];
    [mapView setShowsCompass:true];
    [mapView setShowsUserLocation:true];
    [mapView setShowsPointsOfInterest:true];

    [self.mapViewContainer addSubview: mapView];
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
