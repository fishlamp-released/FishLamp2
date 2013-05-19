//
//	FLPhotoExif.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/25/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class FLGpsExif;

@interface FLPhotoExif : NSObject {
@private;
	NSMutableDictionary* _exif;
}

@property (readonly, strong, nonatomic) NSMutableDictionary* exifDictionary;

- (id) init;
- (id) initWithDictionary:(NSDictionary*) exifDictionary;

@end

@interface FLMasterPhotoExif : FLPhotoExif {
}
@property (readwrite, copy, nonatomic) FLGpsExif* gpsExif;

+ (FLGpsExif*) gpsExifOnlyIfHasGpsCoordinates:(NSDictionary*) masterGps;

@end

@interface FLImagePropertyExif : FLPhotoExif { 
}

@end


@interface FLGpsExif : FLPhotoExif { 
}


@property (readonly, assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (readonly, assign, nonatomic) NSString* coordinateString;

+ (FLGpsExif*) gpsExif;

- (void) setCoordinateWithLocation:(CLLocation*) location;

+ (NSString*) stringForCoordinate:(CLLocationCoordinate2D) coordinate;
+ (NSString*) gpsDateFormattedForExif:(NSDate*) date;

@end


@interface NSDictionary (FLExif)

- (NSDate*) exifDateTimeOriginal;

+ (NSArray*) exifDateTimeDecoders; // returns array of NSDateFormatter

@end