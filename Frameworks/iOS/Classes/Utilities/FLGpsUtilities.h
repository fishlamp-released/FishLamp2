//
//	FLGpsUtilities.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/21/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

extern NSString* FLPrettyStringForCoordinate(CLLocationCoordinate2D coordinate);
extern CLLocationCoordinate2D FLCoordinateFromGpsExif(NSDictionary* gpsDict);
extern void FLAddLocationToGpsExif(NSMutableDictionary* locDict, CLLocation* lastLocation);
extern NSString* FLGpsDateFormattedForExif(NSDate* date);

extern NSDictionary* FLGetGpsExifFromExif(NSDictionary* masterExif);
