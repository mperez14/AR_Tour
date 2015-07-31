//
//  Place.h
//  Around Me
//
//  Created by Matthew Perez on 7/24/15.
//  Copyright (c) 2015 Jean-Pierre Distler. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;

@interface Place : NSObject

@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, copy) NSString *reference;
@property (nonatomic, copy) NSString *placeName;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *website;
@property (nonatomic, copy) NSString *type;

- (id)initWithLocation:(CLLocation *)location reference:(NSString *)reference name:(NSString *)name address:(NSString *)address type:(NSArray *)type;

- (NSString *)infoText;

@end
