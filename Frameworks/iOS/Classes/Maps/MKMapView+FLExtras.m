//
//	MKMapView+FLExtras.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/26/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "MKMapView+FLExtras.h"

#define MERCATOR_OFFSET 268435456
#define MERCATOR_RADIUS 85445659.44705395

@implementation MKMapView (FLExtras)

#pragma mark -
#pragma mark Map conversion methods

+ (double)longitudeToPixelSpaceX:(double)longitude
{
	return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

//- (double)latitudeToPixelSpaceY:(double)latitude
//{
//	  return round(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
//}

+ (double)latitudeToPixelSpaceY:(double)latitude
{
	if (latitude == 90.0) {
		return 0;
	} else if (FLFloatEqualToFloat(latitude, -90.0)) {
		return MERCATOR_OFFSET * 2;
	} else {
		return round(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
	}
}

+ (double)pixelSpaceXToLongitude:(double)pixelX
{
	return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI;
}

+ (double)pixelSpaceYToLatitude:(double)pixelY
{
	return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI;
}

- (NSUInteger) zoomLevel
{
	return 21 - round(log2(self.region.span.longitudeDelta * MERCATOR_RADIUS * M_PI / (180.0 * self.bounds.size.width)));
}



#pragma mark -
#pragma mark Helper methods

//- (MKCoordinateSpan)coordinateSpanWithMapView:(MKMapView *)mapView
//	  centerCoordinate:(CLLocationCoordinate2D)centerCoordinate
//	  andZoomLevel:(NSUInteger)zoomLevel
//{
//	  // convert center coordiate to pixel space
//	  double centerPixelX = [self longitudeToPixelSpaceX:centerCoordinate.longitude];
//	  double centerPixelY = [self latitudeToPixelSpaceY:centerCoordinate.latitude];
//	  
//	  // determine the scale value from the zoom level
//	  NSInteger zoomExponent = 20 - zoomLevel;
//	  double zoomScale = pow(2, zoomExponent);
//	  
//	  // scale the map’s size in pixel space
//	  CGSize mapSizeInPixels = mapView.bounds.size;
//	  double scaledMapWidth = mapSizeInPixels.width * zoomScale;
//	  double scaledMapHeight = mapSizeInPixels.height * zoomScale;
//	  
//	  // figure out the position of the top-left pixel
//	  double topLeftPixelX = centerPixelX - (scaledMapWidth / 2);
//	  double topLeftPixelY = centerPixelY - (scaledMapHeight / 2);
//	  
//	  // find delta between left and right longitudes
//	  CLLocationDegrees minLng = [self pixelSpaceXToLongitude:topLeftPixelX];
//	  CLLocationDegrees maxLng = [self pixelSpaceXToLongitude:topLeftPixelX + scaledMapWidth];
//	  CLLocationDegrees longitudeDelta = maxLng - minLng;
//	  
//	  // find delta between top and bottom latitudes
//	  CLLocationDegrees minLat = [self pixelSpaceYToLatitude:topLeftPixelY];
//	  CLLocationDegrees maxLat = [self pixelSpaceYToLatitude:topLeftPixelY + scaledMapHeight];
//	  CLLocationDegrees latitudeDelta = -1 * (maxLat - minLat);
//	  
//	  // create and return the lat/lng span
//	  MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
//	  return span;
//}

- (MKCoordinateRegion)coordinateRegionWithMapView:(MKMapView *)mapView
					centerCoordinate:(CLLocationCoordinate2D)centerCoordinate
				andZoomLevel:(NSUInteger)zoomLevel
{
	// clamp lat/long values to appropriate ranges
    
    float max = MAX(-90.0, centerCoordinate.latitude);
    
	centerCoordinate.latitude = MIN(max, 90.0);
	centerCoordinate.longitude = FLFloatMod(centerCoordinate.longitude, 180.0);

	// convert center coordiate to pixel space
	double centerPixelX = [MKMapView longitudeToPixelSpaceX:centerCoordinate.longitude];
	double centerPixelY = [MKMapView latitudeToPixelSpaceY:centerCoordinate.latitude];

	// determine the scale value from the zoom level
	NSInteger zoomExponent = 20 - zoomLevel;
	double zoomScale = pow(2, zoomExponent);

	// scale the map’s size in pixel space
	CGSize mapSizeInPixels = mapView.bounds.size;
	double scaledMapWidth = mapSizeInPixels.width * zoomScale;
	double scaledMapHeight = mapSizeInPixels.height * zoomScale;

	// figure out the position of the left pixel
	double topLeftPixelX = centerPixelX - (scaledMapWidth / 2);

	// find delta between left and right longitudes
	CLLocationDegrees minLng = [MKMapView pixelSpaceXToLongitude:topLeftPixelX];
	CLLocationDegrees maxLng = [MKMapView pixelSpaceXToLongitude:topLeftPixelX + scaledMapWidth];
	CLLocationDegrees longitudeDelta = maxLng - minLng;

	// if we’re at a pole then calculate the distance from the pole towards the equator
	// as MKMapView doesn’t like drawing boxes over the poles
	double topPixelY = centerPixelY - (scaledMapHeight / 2);
	double bottomPixelY = centerPixelY + (scaledMapHeight / 2);
	BOOL adjustedCenterPoint = NO;
	if (FLFloatEqualToFloat(topPixelY, MERCATOR_OFFSET * 2)) {
		topPixelY = centerPixelY - scaledMapHeight;
		bottomPixelY = MERCATOR_OFFSET * 2;
		adjustedCenterPoint = YES;
	}

	// find delta between top and bottom latitudes
	CLLocationDegrees minLat = [MKMapView pixelSpaceYToLatitude:topPixelY];
	CLLocationDegrees maxLat = [MKMapView pixelSpaceYToLatitude:bottomPixelY];
	CLLocationDegrees latitudeDelta = -1 * (maxLat - minLat);

	// create and return the lat/lng span
	MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
	MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
	// once again, MKMapView doesn’t like drawing boxes over the poles
	// so adjust the center coordinate to the center of the resulting region
	if (adjustedCenterPoint) {
		region.center.latitude = [MKMapView pixelSpaceYToLatitude:((bottomPixelY + topPixelY) / 2.0)];
	}

	return region;
}

#pragma mark -
#pragma mark Public methods

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
	zoomLevel:(NSInteger)zoomLevel
	animated:(BOOL)animated
{
	// clamp large numbers to 28
	zoomLevel = MAX(zoomLevel, 1);
	zoomLevel = MIN(zoomLevel, 28);
	
	// set the region like normal
	[self setRegion:[self coordinateRegionWithMapView:self centerCoordinate:centerCoordinate andZoomLevel:zoomLevel] animated:animated];
}


-(NSInteger)zoomToFitMapAnnotationsAnimated:(BOOL) animated
{
	if([self.annotations count] == 0)
		return self.zoomLevel;
   
	CLLocationCoordinate2D topLeftCoord;
	topLeftCoord.latitude = -90;
	topLeftCoord.longitude = 180;
   
	CLLocationCoordinate2D bottomRightCoord;
	bottomRightCoord.latitude = 90;
	bottomRightCoord.longitude = -180;
   
	for(MKPointAnnotation* annotation in self.annotations)
	{
		topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
		topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
	   
		bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
		bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
	}
   
	MKCoordinateRegion region;
	region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
	region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
	region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; // Add a little extra space on the sides
	region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; // Add a little extra space on the sides
   
	region = [self regionThatFits:region];
	[self setRegion:region animated:animated];
	
	return self.zoomLevel;
}

@end 

