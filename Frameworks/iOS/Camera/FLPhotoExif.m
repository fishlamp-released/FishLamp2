//
//	FLPhotoExif.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/25/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLPhotoExif.h"
#import "FLGpsUtilities.h"

@implementation FLPhotoExif

@synthesize exifDictionary = _exif;

- (id) initWithDictionary:(NSDictionary*) dictionary
{
	if((self = [super init]))
	{
		_exif = [dictionary mutableCopy];
	}
	
	return self;
}

- (id) init
{
	if((self = [super init]))
	{
		_exif = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (void) dealloc
{
	FLRelease(_exif);
	FLSuperDealloc();
}

@end

@implementation FLMasterPhotoExif
- (FLGpsExif*) gpsExif
{
	return FLAutorelease([[FLGpsExif alloc] initWithDictionary:[self.exifDictionary objectForKey:(NSString*)kCGImagePropertyGPSDictionary]]);
}

- (void) setGpsExif:(FLGpsExif*) gpsExif
{
	[self.exifDictionary setObject:FLAutorelease([gpsExif.exifDictionary mutableCopy]) forKey:(NSString*)kCGImagePropertyGPSDictionary];
}

+ (FLGpsExif*) gpsExifOnlyIfHasGpsCoordinates:(NSDictionary*) masterGps
{
	NSDictionary* gps = [masterGps objectForKey:(NSString*)kCGImagePropertyGPSDictionary];
	NSNumber* lat = [gps objectForKey:(NSString*)kCGImagePropertyGPSLatitude];
	NSNumber* lng = [gps objectForKey:(NSString*)kCGImagePropertyGPSLongitude];
	return lat && lng ? FLAutorelease([[FLGpsExif alloc] initWithDictionary:gps]) : nil;
}

@end


@implementation FLImagePropertyExif
@end

@implementation FLGpsExif

+ (FLGpsExif*) gpsExif
{
	return FLAutorelease([[FLGpsExif alloc] init]);
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
	return [FLGpsExif stringForCoordinate:self.coordinate];
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

@implementation NSDictionary (FLExif)

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
                
                [s_exifFormatters addObject:FLAutorelease([[NSDateFormatter alloc] init])
                            configureObject:^(id date) {
                                [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // @"yyyy:mm:dd HH:MM:SS"];            
                            }];
                [s_exifFormatters addObject:FLAutorelease([[NSDateFormatter alloc] init])
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
        if(FLStringIsNotEmpty(takenDate))
        {
            for(NSDateFormatter* formatter in [NSDictionary exifDateTimeDecoders])
            {
                NSDate* date = [formatter dateFromString:takenDate];
                if(date)
                {
                    return date;
                }
            }
            
            
            FLAssertFailedWithComment(@"unable to decode date");
        }
    }


    return nil;
}

@end
