//
//	GtPhotoExif.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/25/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@class GtGpsExif;

@interface GtPhotoExif : NSObject {
@private;
	NSMutableDictionary* m_exif;
}

@property (readonly, assign, nonatomic) NSMutableDictionary* exifDictionary;

- (id) init;
- (id) initWithDictionary:(NSDictionary*) exifDictionary;

@end

@interface GtMasterPhotoExif : GtPhotoExif {
}
@property (readwrite, copy, nonatomic) GtGpsExif* gpsExif;

+ (GtGpsExif*) gpsExifOnlyIfHasGpsCoordinates:(NSDictionary*) masterGps;

@end

@interface GtImagePropertyExif : GtPhotoExif { 
}

@end


@interface GtGpsExif : GtPhotoExif { 
}


@property (readonly, assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (readonly, assign, nonatomic) NSString* coordinateString;

+ (GtGpsExif*) gpsExif;

- (void) setCoordinateWithLocation:(CLLocation*) location;

+ (NSString*) stringForCoordinate:(CLLocationCoordinate2D) coordinate;
+ (NSString*) gpsDateFormattedForExif:(NSDate*) date;

@end


@interface NSDictionary (GtExif)

- (NSDate*) exifDateTimeOriginal;

+ (NSArray*) exifDateTimeDecoders; // returns array of NSDateFormatter

@end