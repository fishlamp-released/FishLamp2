//
//	GtPhotoExif.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/25/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPhotoExif.h"
#import "GtGpsUtilities.h"

@implementation GtPhotoExif

@synthesize exifDictionary = m_exif;

- (id) initWithDictionary:(NSDictionary*) dictionary
{
	if((self = [super init]))
	{
		m_exif = [dictionary mutableCopy];
	}
	
	return self;
}

- (id) init
{
	if((self = [super init]))
	{
		m_exif = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_exif);
	GtSuperDealloc();
}

@end

@implementation GtMasterPhotoExif
- (GtGpsExif*) gpsExif
{
	return GtReturnAutoreleased([[GtGpsExif alloc] initWithDictionary:[self.exifDictionary objectForKey:(NSString*)kCGImagePropertyGPSDictionary]]);
}

- (void) setGpsExif:(GtGpsExif*) gpsExif
{
	[self.exifDictionary setObject:GtReturnAutoreleased([gpsExif.exifDictionary mutableCopy]) forKey:(NSString*)kCGImagePropertyGPSDictionary];
}

+ (GtGpsExif*) gpsExifOnlyIfHasGpsCoordinates:(NSDictionary*) masterGps
{
	NSDictionary* gps = [masterGps objectForKey:(NSString*)kCGImagePropertyGPSDictionary];
	NSNumber* lat = [gps objectForKey:(NSString*)kCGImagePropertyGPSLatitude];
	NSNumber* lng = [gps objectForKey:(NSString*)kCGImagePropertyGPSLongitude];
	return lat && lng ? GtReturnAutoreleased([[GtGpsExif alloc] initWithDictionary:gps]) : nil;
}

@end


@implementation GtImagePropertyExif
@end

@implementation GtGpsExif

+ (GtGpsExif*) gpsExif
{
	return GtReturnAutoreleased([[GtGpsExif alloc] init]);
}

- (CLLocationCoordinate2D) coordinate
{
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = [[self.exifDictionary objectForKey:(NSString*) kCGImagePropertyGPSLatitude] doubleValue];
	coordinate.longitude =	[[self.exifDictionary objectForKey:(NSString*) kCGImagePropertyGPSLongitude] doubleValue];

	if([[self.exifDictionary objectForKey:(NSString*) kCGImagePropertyGPSLatitudeRef] isEqualToString:@"S"])
	{
		coordinate.latitude *= -1;
	}
	if([[self.exifDictionary objectForKey:(NSString*) kCGImagePropertyGPSLongitudeRef] isEqualToString:@"W"])
	{
		coordinate.longitude *= -1;
	}

	return coordinate;
}

- (NSString*) coordinateString
{
	return [GtGpsExif stringForCoordinate:self.coordinate];
}

- (void) setCoordinateWithLocation:(CLLocation*) location
{
	if(CLLocationCoordinate2DIsValid(location.coordinate))
	{
		NSMutableDictionary* locDict = self.exifDictionary;
		[locDict setObject:location.timestamp forKey:(NSString*)kCGImagePropertyGPSTimeStamp];
				
		if (location.coordinate.latitude <0.0)
		{ 
			[locDict setObject:@"S" forKey:(NSString*)kCGImagePropertyGPSLatitudeRef];
		}
		else
		{ 
			[locDict setObject:@"N" forKey:(NSString*)kCGImagePropertyGPSLatitudeRef];
		} 

		[locDict setObject:[NSNumber numberWithFloat:fabs(location.coordinate.latitude)] forKey:(NSString*)kCGImagePropertyGPSLatitude];
		
		if (location.coordinate.longitude <0.0)
		{ 
			[locDict setObject:@"W" forKey:(NSString*)kCGImagePropertyGPSLongitudeRef];
		}
		else
		{ 
			[locDict setObject:@"E" forKey:(NSString*)kCGImagePropertyGPSLongitudeRef];
		} 
		
		[locDict setObject:[NSNumber numberWithFloat:fabs(location.coordinate.longitude)] forKey:(NSString*)kCGImagePropertyGPSLongitude];
	}
			
}

+ (NSString*) stringForCoordinate:(CLLocationCoordinate2D) coordinate
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
	NSString *longt = [NSString stringWithFormat:@"%d° %d' %1.1f %@\"", 
					   degrees, minutes, seconds, coordinate.longitude < 0 ? @"W" : @"E"];
	return [NSString stringWithFormat:@"%@, %@", lat, longt];
}

+ (NSString*) gpsDateFormattedForExif:(NSDate*) date
{
	NSDateComponents* components = [[NSCalendar currentCalendar] components:	
		NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
		fromDate:date];
	
	return [NSString stringWithFormat:@"%.4d-%.2d-%.2d %.2d:%.2d:%.2d", 
		components.year, components.month, components.day, components.hour, components.minute, components.second];
}
@end

@implementation NSDictionary (GtExif)

+ (NSArray*) exifDateTimeDecoders
{
    static NSMutableArray* s_exifFormatters = nil;
	if(!s_exifFormatters)
	{
        @synchronized(self)
        {
            if(!s_exifFormatters)
            {
                s_exifFormatters = [[NSMutableArray alloc] init];
                
                [s_exifFormatters addObject:GtReturnAutoreleased([[NSDateFormatter alloc] init])
                            configureObject:^(id date) {
                                [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // @"yyyy:mm:dd HH:MM:SS"];            
                            }];
                [s_exifFormatters addObject:GtReturnAutoreleased([[NSDateFormatter alloc] init])
                            configureObject:^(id date) {
                                [date setDateFormat:@"yyyy:MM:dd HH:mm:ss"]; // @"yyyy:mm:dd HH:MM:SS"];            
                            }];
            }
        }
	}

    return s_exifFormatters;
}


- (NSDate*) exifDateTimeOriginal
{
    NSDictionary* exif = [self objectForKey:(NSString*)kCGImagePropertyExifDictionary];
    if(exif)
    {
        NSString* takenDate = [exif objectForKey:(NSString*)kCGImagePropertyExifDateTimeOriginal];
        if(GtStringIsNotEmpty(takenDate))
        {
            for(NSDateFormatter* formatter in [NSDictionary exifDateTimeDecoders])
            {
                NSDate* date = [formatter dateFromString:takenDate];
                if(date)
                {
                    return date;
                }
            }
            
            
            GtAssertFailed(@"unable to decode date");
        }
    }


    return nil;
}

@end
