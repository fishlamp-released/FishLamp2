//
//	MKMapView+FLExtras.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/26/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MKMapView (FLExtras)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
	zoomLevel:(NSInteger)zoomLevel
	animated:(BOOL)animated;

@property (readonly, assign, nonatomic) NSUInteger zoomLevel;

-(NSInteger)zoomToFitMapAnnotationsAnimated:(BOOL) animated;

@end 
