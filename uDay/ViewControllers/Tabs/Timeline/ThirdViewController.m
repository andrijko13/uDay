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
    Entry *selected;
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
    [mapView removeAnnotations:mapView.annotations];
    [self addAnnotations];

    [mapView setDelegate:self];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.prefersLargeTitles = TRUE;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)addAnnotations {
    RLMResults<Entry *>* results = [[DataStore main] fetchEntries];
    for (Entry *result in results) {
        CustomAnnotation *annotation = [[CustomAnnotation alloc] init];
        [annotation setCoordinate:CLLocationCoordinate2DMake(result.location.latitude, result.location.longitude)];
        [annotation setTitle:result.location.name];
        [annotation setContext:result];

        if (result.isGoal) {
            if (result.complete) {
                [annotation setColor:LightGreen];
            } else {
                [annotation setColor:LightOrange];
            }
        } else {
            [annotation setColor:LightBlue];
        }
        if (result.location.desc != nil) {
            [annotation setSubtitle:result.location.desc];
        }

        [mapView addAnnotation:annotation];
    }
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isKindOfClass:CustomAnnotation.class]) {
        selected = ((CustomAnnotation *)view.annotation).context;
        [self performSegueWithIdentifier:@"detailSegue" sender:self];
    }
}

//-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    //MKAnnotationView *v = 
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailSegue"] && [segue destinationViewController].class == [ViewEntryViewController class]) {
        ViewEntryViewController *vc = [segue destinationViewController];

        vc.context = selected;
    }
}

@end
