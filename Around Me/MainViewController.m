//
//  MainViewController.m
//  Around Me
//
//  Created by Jean-Pierre Distler on 30.01.13.
//  Copyright (c) 2013 Jean-Pierre Distler. All rights reserved.
// Main map, with pins

#import "MainViewController.h"
#import "Place.h"
#import "PlaceAnnotation.h"

NSString * const kNameKey = @"name";
NSString * const kReferenceKey = @"reference";
NSString * const kAddressKey = @"vicinity";
NSString * const kLatitudeKeypath = @"geometry.location.lat";
NSString * const kLongitudeKeypath = @"geometry.location.lng";
NSArray * const kType = @"types";

@interface MainViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, strong) NSArray *locations;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation MainViewController
//@synthesize locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setLocationManager:[[CLLocationManager alloc] init]];
    
    [_locationManager setDelegate:self];
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [_locationManager startUpdatingLocation];
    
    
                        //range slider set up
    _rangeSlider.maximumValue = 2000;
    _rangeSlider.minimumValue=0;
    _rangeSlider.continuous = YES;
    _rangeSlider.value = 1000;
    range = _rangeSlider.value;   //mi conversion
    float range_mi = _rangeSlider.value/1000 * 0.621371f;
    _rangeCounter.text = [NSString stringWithFormat:@"%.2f", range_mi];
    [_rangeCounter sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        [[segue destinationViewController] setLocations:_locations];
        [[segue destinationViewController] setUserLocation:[_mapView userLocation]];
    }
}

#pragma mark - Functions
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //1
    CLLocation *lastLocation = [locations lastObject];
    
    //2
    CLLocationAccuracy accuracy = [lastLocation horizontalAccuracy];
    NSLog(@"Received location %@ with accuracy %f", lastLocation, accuracy);
    
    //3
    if(accuracy < 100.0) {
        //4
        MKCoordinateSpan span = MKCoordinateSpanMake(0.14, 0.14);
        MKCoordinateRegion region = MKCoordinateRegionMake([lastLocation coordinate], span);
        
        [_mapView setRegion:region animated:YES];
        
        // More code here
        [[PlacesLoader sharedInstance] loadPOIsForLocation:[locations lastObject] radius:_rangeSlider.value successHandler:^(NSDictionary *response) {
            NSLog(@"Response: %@", response);
            //1
            if([[response objectForKey:@"status"] isEqualToString:@"OK"]) {
                //2
                id places = [response objectForKey:@"results"];
                NSLog(@"places: %@",places);
                //3
                NSMutableArray *temp = [NSMutableArray array];
                
                //4
                if([places isKindOfClass:[NSArray class]]) {
                    for(NSDictionary *resultsDict in places) {
                        //5
                        CLLocation *location = [[CLLocation alloc] initWithLatitude:[[resultsDict valueForKeyPath:kLatitudeKeypath] floatValue] longitude:[[resultsDict valueForKeyPath:kLongitudeKeypath] floatValue]];
                        
                        //6
                        Place *currentPlace = [[Place alloc] initWithLocation:location reference:[resultsDict objectForKey:kReferenceKey] name:[resultsDict objectForKey:kNameKey] address:[resultsDict objectForKey:kAddressKey] type:[resultsDict objectForKey:kType]];
                        NSLog(@"Current Place: %@", currentPlace.type);
                        [temp addObject:currentPlace];
                        
                        //7
                        PlaceAnnotation *annotation = [[PlaceAnnotation alloc] initWithPlace:currentPlace];
                        [_mapView addAnnotation:annotation];
                    }
                }
                //8
                _locations = [temp copy];
                NSLog(@"Locations: %@", _locations);
            }
        } errorHandler:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        //end of for loop
        
        [manager stopUpdatingLocation];
    }
}

- (IBAction)sliderAction:(id)sender {
    NSLog(@"updated");
    range = _rangeSlider.value;   //mi conversion
    float range_mi = _rangeSlider.value/1000 * 0.621371f;
    _rangeCounter.text = [NSString stringWithFormat:@"%.2f", range_mi];
    [_rangeCounter sizeToFit];
    
    [_mapView removeAnnotations:_mapView.annotations];  //get rid of all pins
    
    
    [self setLocationManager:[[CLLocationManager alloc] init]];
    [_locationManager setDelegate:self];
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [_locationManager startUpdatingLocation];

}
@end
