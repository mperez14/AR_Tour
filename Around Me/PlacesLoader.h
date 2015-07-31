//
//  PlacesLoader.h
//  Around Me
//
//  Created by Matthew Perez on 7/24/15.
//  Copyright (c) 2015 Jean-Pierre Distler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"

//1
@class CLLocation;
@class Place;

//2
typedef void (^SuccessHandler)(NSDictionary *responseDict);
typedef void (^ErrorHandler)(NSError *error);

@interface PlacesLoader : NSObject

//3
+ (PlacesLoader *)sharedInstance;

//4
- (void)loadPOIsForLocation:(CLLocation *)location radius:(int)radius successHandler:(SuccessHandler)handler errorHandler:(ErrorHandler)errorHandler;

- (void)loadDetailInformation:(Place *)location successHanlder:(SuccessHandler)handler errorHandler:(ErrorHandler)errorHandler;


@end