//
//  MarkerView.m
//  Around Me
//
//  Created by Matthew Perez on 7/25/15.
//  Copyright (c) 2015 Jean-Pierre Distler. All rights reserved.
// Displays Markers on screen

#import "MarkerView.h"
#import "ARGeoCoordinate.h"
#import <FontAwesomeKit.h>
#import "Place.h"

const float kWidth = 200.0f;
const float kHeight = 100.0f;

@interface MarkerView ()

@property (nonatomic, strong) UILabel *lblDistance;

@end

@implementation MarkerView

- (id)initWithCoordinate:(ARGeoCoordinate *)coordinate type:(NSString *)type delegate:(id<MarkerViewDelegate>)delegate {
    //1
    if((self = [super initWithFrame:CGRectMake(0.0f, 0.0f, kWidth, kHeight)])) {
        
        //2
        _coordinate = coordinate;
        _delegate = delegate;
        
        [self setUserInteractionEnabled:YES];
        
        //3
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kWidth, 40.0f)];
        [title setBackgroundColor:[UIColor colorWithWhite:0.3f alpha:0.7f]];
        [title setTextColor:[UIColor whiteColor]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [title setText:[coordinate title]];
        [title sizeToFit];
        
        //mapmarker for special places
        //homeicon for dorms
        //university icon for academic buildings
        //spiritual/chapel
        //cutlery icon for dining halls
        //trophy icon for atheltic
        
        FAKFontAwesome *icon;
        if([type isEqualToString:@"university"] || [type isEqualToString:@"school"]){
            icon = [FAKFontAwesome universityIconWithSize:20];
        }else if([type isEqualToString:@"lodging"]){
            icon = [FAKFontAwesome homeIconWithSize:20];
        }else if([type isEqualToString:@"restaurant"] || [type isEqualToString:@"food"]){
            icon = [FAKFontAwesome cutleryIconWithSize:20];
        }else if([type isEqualToString:@"stadium"]){
            icon = [FAKFontAwesome trophyIconWithSize:20];
        }
        [icon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
        UIImage *iconImage = [icon imageWithSize:CGSizeMake(20, 20)];
        UIImageView *iconView = [[UIImageView alloc] initWithImage:iconImage];
        iconView.frame = CGRectMake(title.frame.origin.x - 25, title.frame.origin.y, 20, 20);
        [title addSubview:iconView];
        
        //4
        _lblDistance = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 45.0f,kWidth,  40.0f)];
        [_lblDistance setBackgroundColor:[UIColor colorWithWhite:0.3f alpha:0.7f]];
        [_lblDistance setTextColor:[UIColor whiteColor]];
        [_lblDistance setTextAlignment:NSTextAlignmentCenter];
        float mi = [coordinate distanceFromOrigin]/1000.0f * .621371;
        [_lblDistance setText:[NSString stringWithFormat:@"  %.2f mi  ", mi]];
        [_lblDistance sizeToFit];
        
        //5
        [self addSubview:title];
        [self addSubview:_lblDistance];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}

//allows for more details when touching marker
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(_delegate && [_delegate conformsToProtocol:@protocol(MarkerViewDelegate)]) {
        [_delegate didTouchMarkerView:self];
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect theFrame = CGRectMake(0, 0, kWidth, kHeight);
    
    return CGRectContainsPoint(theFrame, point);
}

- (void)drawRect:(CGRect)rect { //displays name and distance from marker
    [super drawRect:rect];
    float km = [[self coordinate] distanceFromOrigin] / 1000.0f;
    float mi = km * .621371f;
    [[self lblDistance] setText:[NSString stringWithFormat:@"%.2f mi", mi]];
}

@end
