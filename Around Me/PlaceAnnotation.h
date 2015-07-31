//
//  PlaceAnnotation.h
//  Around Me
//
//  Created by Matthew Perez on 7/24/15.
//  Copyright (c) 2015 Jean-Pierre Distler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class Place;

@interface PlaceAnnotation : NSObject <MKAnnotation>

- (id)initWithPlace:(Place *)place;
- (CLLocationCoordinate2D)coordinate;
- (NSString *)title;

@end