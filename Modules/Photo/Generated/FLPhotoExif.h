//
//	FLPhotoExif.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/25/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLGpsExif;

@interface FLPhotoExif : NSObject {
@private;
	NSMutableDictionary* m_exif;
}

@property (readonly, assign, nonatomic) NSMutableDictionary* exifDictionary;

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