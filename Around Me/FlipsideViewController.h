//
//  FlipsideViewController.h
//  Around Me
//
//  Created by Jean-Pierre Distler on 30.01.13.
//  Copyright (c) 2013 Jean-Pierre Distler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ARKit.h"
#import "MarkerView.h"

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController <ARLocationDelegate, ARDelegate, ARMarkerDelegate>

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *locations;   //store POI's from google
@property (nonatomic, strong) MKUserLocation *userLocation;

- (IBAction)done:(id)sender;

@end
