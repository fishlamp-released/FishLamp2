//
//	FLGpsUtilities.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/21/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLGpsUtilities.h"

NSString* FLPrettyStringForCoordinate(CLLocationCoordinate2D coordinate)
{
	int degrees = coordinate.latitude;
	double decimal = fabs(coordinate.latitude - degrees);
	int minutes = decimal * 60;
	double seconds = decimal * 3600 - minutes * 60;
	NSString *lat = [NSString stringWithFormat:@"%d° %d' %1.1f\" %@", 
					 degrees, minutes, seconds, coordinate.latitude < 0 ? @"S" : @"N"];
	degrees = coordinate.longitude;
	
	decimal = fabs(coordinate.longitude - degrees);
	minutes = decimal * 60;
	seconds = decimal * 3600 - minutes * 60;
	NSString *longt = [NSString stringWithFormat:@"%d° %d' %1.1f\" %@", 
					   degrees, minutes, seconds, coordinate.longitude < 0 ? @"W" : @"E"];
	return [NSString stringWithFormat:@"%@, %@", lat, longt];
}

CLLocationCoordinate2D FLCoordinateFromGpsExif(NSDictionary* gpsDict)
{
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = [[gpsDict objectForKey:(NSString*) kCGImagePropertyGPSLatitude] doubleValue];
	coordinate.longitude =	[[gpsDict objectForKey:(NSString*) kCGImagePropertyGPSLongitude] doubleValue];

	if([[gpsDict objectForKey:(NSString*) kCGImagePropertyGPSLatitudeRef] isEqualToString:@"S"])
	{
		coordinate.latitude *= -1;
	}
	if([[gpsDict objectForKey:(NSString*) kCGImagePropertyGPSLongitudeRef] isEqualToString:@"W"])
	{
		coordinate.longitude *= -1;
	}

	return coordinate;

}

void FLAddLocationToGpsExif(NSMutableDictionary* locDict, CLLocation* lastLocation)
{
	if(CLLocationCoordinate2DIsValid(lastLocation.coordinate))
	{
		[locDict setObject:lastLocation.timestamp forKey:(NSString*)kCGImagePropertyGPSTimeStamp];
				
		if (lastLocation.coordinate.latitude <0.0)
		{ 
			[locDict setObject:@"S" forKey:(NSString*)kCGImagePropertyGPSLatitudeRef];
		}
		else
		{ 
			[locDict setObject:@"N" forKey:(NSString*)kCGImagePropertyGPSLatitudeRef];
		} 

		[locDict setObject:[NSNumber numberWithFloat:fabs(lastLocation.coordinate.latitude)] forKey:(NSString*)kCGImagePropertyGPSLatitude];
		
		if (lastLocation.coordinate.longitude <0.0)
		{ 
			[locDict setObject:@"W" forKey:(NSString*)kCGImagePropertyGPSLongitudeRef];
		}
		else
		{ 
			[locDict setObject:@"E" forKey:(NSString*)kCGImagePropertyGPSLongitudeRef];
		} 
		
		[locDict setObject:[NSNumber numberWithFloat:fabs(lastLocation.coordinate.longitude)] forKey:(NSString*)kCGImagePropertyGPSLongitude];
	}
			
}

NSString* FLGpsDateFormattedForExif(NSDate* date)
{
	NSDateComponents* components = [[NSCalendar currentCalendar] components:	
		NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
		fromDate:date];
	
	return [NSString stringWithFormat:@"%.4d-%.2d-%.2d %.2d:%.2d:%.2d", 
		components.year, components.month, components.day, components.hour, components.minute, components.second];
}

