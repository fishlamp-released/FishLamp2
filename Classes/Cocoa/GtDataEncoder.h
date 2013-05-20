//
//	GtDataEncoder.h
//	PackMule
//
//	Created by Mike Fullerton on 4/20/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtDataTypeID.h"

@protocol GtDataEncoder <NSObject>

- (void) encodeDataToString:(id) data 
		forType:(GtDataTypeID) type
		outEncodedString:(NSString**) outString;

@end

@protocol GtDataDecoder <NSObject>

- (void) decodeDataFromString:(NSString*) inEncodedString
		forType:(GtDataTypeID) type
		outObject:(id*) outData;		

@end



