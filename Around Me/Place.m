//
//  Place.m
//  Around Me
//
//  Created by Matthew Perez on 7/24/15.
//  Copyright (c) 2015 Jean-Pierre Distler. All rights reserved.
//

#import "Place.h"

@implementation Place

- (id)initWithLocation:(CLLocation *)location reference:(NSString *)reference name:(NSString *)name address:(NSString *)address type:(NSArray *)type{
    if((self = [super init])) {
        _location = location;
        _reference = reference;
        _placeName = name;
        _address = address;
        _type = type[0];
    }
    return self;
}

- (NSString *)infoText {
    return [NSString stringWithFormat:@"Name:%@\nAddress:%@\nPhone:%@\nWeb:%@", _placeName, _address, _phoneNumber, _website];
}

@end
