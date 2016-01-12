//
//  MainViewController.h
//  Around Me
//
//  Created by Jean-Pierre Distler on 30.01.13.
//  Copyright (c) 2013 Jean-Pierre Distler. All rights reserved.
//

#import "FlipsideViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PlacesLoader.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,CLLocationManagerDelegate, MKMapViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    float range;
}
//@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *rangeCounter;
@property (weak, nonatomic) IBOutlet UISlider *rangeSlider;
- (IBAction)sliderAction:(id)sender;
@property (nonatomic, retain) IBOutlet UIPickerView *POIPicker;
@property (strong, nonatomic) NSArray *POITopics;
extern NSString *type;
@end
