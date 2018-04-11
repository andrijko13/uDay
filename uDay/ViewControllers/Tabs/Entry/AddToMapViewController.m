//
//  AddToMapViewController.m
//  uDay
//
//  Created by Andriko on 2/13/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import "AddToMapViewController.h"

@interface AddToMapViewController ()
{
    CLLocationManager *locationManager;
    NSMutableArray *matchingItems;

    MKPointAnnotation *current;
}
@end

@implementation AddToMapViewController
@synthesize mapViewContainer;
@synthesize mapView;
@synthesize searchBar;
@synthesize addButton;
@synthesize delegate;

-  (void)style {
    [self.view setBackgroundColor: [[Styler main] colorForKey:DarkGray]];
    UIImage *image = [self getImageWithColor:[[Styler main] colorForKey:LightWhite] size:CGSizeMake(30, 30)];
    [searchBar setSearchFieldBackgroundImage:image forState:UIControlStateNormal];
    [searchBar setBarTintColor:[[Styler main] colorForKey:BarGrayTranslucent]];
    [searchBar setPlaceholder:@"Search for Locations"];

    [searchBar setSearchTextPositionAdjustment:UIOffsetMake(5.0f, 0.0f)];

    [addButton setBackgroundColor:[[Styler main] colorForKey:LightBlue]];
    [addButton.layer setCornerRadius:5.0f];
    [addButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    [self.view bringSubviewToFront:addButton];

    [[UITextField appearanceWhenContainedInInstancesOfClasses:[NSArray arrayWithObjects:[UISearchBar class], nil]] setFont:[UIFont systemFontOfSize:12]];
}

- (void)viewDidLoad {
    [self style];

    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestLocation];
    searchBar.delegate = self;
    [addButton setHidden:true];

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(UIImage *) getImageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:6.8];
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    [color setFill];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)viewWillAppear:(BOOL)animated {
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, mapViewContainer.frame.size.width, mapViewContainer.frame.size.height)];
    [mapView setMapType:MKMapTypeStandard];
    [mapView setShowsScale:true];
    [mapView setShowsCompass:true];
    [mapView setShowsUserLocation:true];
    [mapView setShowsPointsOfInterest:true];
    mapView.delegate = self;

    [self.mapViewContainer addSubview: mapView];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:true animated:true];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:false animated:true];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setText:@""];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];

    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    [request setNaturalLanguageQuery:searchBar.text];
    [request setRegion:mapView.region];

    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    UIView *view = [[UIView alloc] initWithFrame:mapView.frame];
    view.backgroundColor = [[Styler main] colorForKey:Black alpha:0.8];
    [view setCenter:CGPointMake(mapView.center.x, mapView.center.y+searchBar.frame.size.height)];
    [spinner setCenter:CGPointMake(mapView.center.x, mapView.center.y+searchBar.frame.size.height)];
    [self.view addSubview:spinner];
    [self.view addSubview:view];
    __weak id weakSelf = self;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [spinner startAnimating];
        });

        [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [view removeFromSuperview];
                [spinner stopAnimating];
            });

            if (response == nil) return;

            matchingItems = [NSMutableArray arrayWithArray:response.mapItems];
            [weakSelf responseReceived:response];
        }];
    });
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [locationManager requestLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.firstObject;

    if (location) {
        MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
        MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
        [mapView setRegion:region];
    }
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog( @"%@", error.description);
}

-(void)responseReceived:(MKLocalSearchResponse *)response {
    [addButton setHidden:true];
    [mapView removeAnnotations:mapView.annotations];

    MKCoordinateSpan span = MKCoordinateSpanMake(0.05+response.boundingRegion.span.latitudeDelta, 0.05+response.boundingRegion.span.longitudeDelta);
    MKCoordinateRegion region = MKCoordinateRegionMake(response.boundingRegion.center, span);

    [mapView setRegion:region];

    for (MKMapItem *item in matchingItems) {
        [self dropPinZoomInPlacemark:item.placemark];
    }
}

-(void) dropPinZoomInPlacemark:(MKPlacemark *)placemark {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:placemark.coordinate];
    [annotation setTitle:placemark.name];

    if (placemark.locality != nil && placemark.administrativeArea != nil) {
        [annotation setSubtitle:[NSString stringWithFormat:@"%@ %@", placemark.locality, placemark.administrativeArea]];
    }

    [mapView addAnnotation:annotation];


//    selectedPin = placemark
//    mapView.removeAnnotations(mapView.annotations)
//    let annotation = MKPointAnnotation()
//    annotation.coordinate = placemark.coordinate
//    annotation.title = placemark.name
//    if let city = placemark.locality,
//        let state = placemark.administrativeArea {
//            annotation.subtitle = "(city) (state)"
//        }
//    mapView.addAnnotation(annotation)
//    let span = MKCoordinateSpanMake(0.05, 0.05)
//    let region = MKCoordinateRegionMake(placemark.coordinate, span)
//    mapView.setRegion(region, animated: true)
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    current = view.annotation;
    [self.view bringSubviewToFront:addButton];
    [addButton setHidden:false];
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    current = nil;
    [self.view bringSubviewToFront:mapViewContainer];
    [addButton setHidden:true];
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    printf("he");
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

- (IBAction)addClicked:(id)sender {
    RLMLocation *location = [RLMLocation new];
    location.latitude = current.coordinate.latitude;
    location.longitude = current.coordinate.longitude;
    location.name = current.title;
    location.desc = current.subtitle;
    [delegate addLocation:location];
    [self.navigationController popViewControllerAnimated:true];
}
@end
