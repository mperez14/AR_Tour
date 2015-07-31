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

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,CLLocationManagerDelegate, MKMapViewDelegate>{
    
}
//@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//@property (nonatomic, strong) CLLocationManager *locationManager;

@end
