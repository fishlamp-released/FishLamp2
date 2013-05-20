//
//	GtGpsUtilities.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/21/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

extern NSString* GtPrettyStringForCoordinate(CLLocationCoordinate2D coordinate);
extern CLLocationCoordinate2D GtCoordinateFromGpsExif(NSDictionary* gpsDict);
extern void GtAddLocationToGpsExif(NSMutableDictionary* locDict, CLLocation* lastLocation);
extern NSString* GtGpsDateFormattedForExif(NSDate* date);

extern NSDictionary* GtGetGpsExifFromExif(NSDictionary* masterExif);
