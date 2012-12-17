//
//	FLDataEncoder.h
//	PackMule
//
//	Created by Mike Fullerton on 4/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLCore.h"

#import "FLDataTypeID.h"

@protocol FLDataEncoder <NSObject>

- (void) encodeDataToString:(id) data 
		forType:(FLDataTypeID) type
		outEncodedString:(NSString**) outString;

@end

@protocol FLDataDecoder <NSObject>

- (void) decodeDataFromString:(NSString*) inEncodedString
		forType:(FLDataTypeID) type
		outObject:(id*) outData;		

@end



