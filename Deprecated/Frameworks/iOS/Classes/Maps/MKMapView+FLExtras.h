//
//	MKMapView+FLExtras.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/26/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>


@interface MKMapView (FLExtras)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
	zoomLevel:(NSInteger)zoomLevel
	animated:(BOOL)animated;

@property (readonly, assign, nonatomic) NSUInteger zoomLevel;

-(NSInteger)zoomToFitMapAnnotationsAnimated:(BOOL) animated;

@end 
