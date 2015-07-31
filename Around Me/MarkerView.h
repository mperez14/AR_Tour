//
//  MarkerView.h
//  Around Me
//
//  Created by Matthew Perez on 7/25/15.
//  Copyright (c) 2015 Jean-Pierre Distler. All rights reserved.
//

#import <UIKit/UIKit.h>

//1
@class ARGeoCoordinate;
@protocol MarkerViewDelegate;

@interface MarkerView : UIView

//2
@property (nonatomic, strong) ARGeoCoordinate *coordinate;
@property (nonatomic, weak) id <MarkerViewDelegate> delegate;

//3
- (id)initWithCoordinate:(ARGeoCoordinate *)coordinate type:(NSString *)type delegate:(id<MarkerViewDelegate>)delegate;

@end

//4
@protocol MarkerViewDelegate <NSObject>

- (void)didTouchMarkerView:(MarkerView *)markerView;

@end