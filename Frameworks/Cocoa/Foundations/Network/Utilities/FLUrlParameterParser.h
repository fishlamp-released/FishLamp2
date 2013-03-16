//
//  FLUrlParameterParser.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/3/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

#define FLUrlParamenterParserErrorDomain @"FLUrlParamenterParserErrorDomain"

typedef enum {
	FLUrlParameterParserErrorCodeUnexpectedData = 1,
	FLUrlParameterParserErrorCodeMissingRequiredKey,
} FLUrlParameterParserErrorCode; 

@interface FLUrlParameterParser : NSObject {

}

+ (BOOL) parseString:(NSString*) string intoObject:(id) object strict:(BOOL) strict;
+ (BOOL) parseData:(NSData*) data intoObject:(id) object strict:(BOOL) strict;

+ (BOOL) parseString:(NSString*) string intoObject:(id) object strict:(BOOL) strict requiredKeys:(NSArray*) requiredKeys;
+ (BOOL) parseData:(NSData*) data intoObject:(id) object strict:(BOOL) strict  requiredKeys:(NSArray*) requiredKeys;


@end
