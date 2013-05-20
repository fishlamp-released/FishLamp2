//
//  GtUrlParameterParser.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/3/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#define GtUrlParamenterParserErrorDomain @"GtUrlParamenterParserErrorDomain"

typedef enum {
	GtUrlParameterParserErrorCodeUnexpectedData = 1,
	GtUrlParameterParserErrorCodeMissingRequiredKey,
} GtUrlParameterParserErrorCode; 

@interface GtUrlParameterParser : NSObject {

}

+ (BOOL) parseString:(NSString*) string intoObject:(id) object strict:(BOOL) strict;
+ (BOOL) parseData:(NSData*) data intoObject:(id) object strict:(BOOL) strict;

+ (BOOL) parseString:(NSString*) string intoObject:(id) object strict:(BOOL) strict requiredKeys:(NSArray*) requiredKeys;
+ (BOOL) parseData:(NSData*) data intoObject:(id) object strict:(BOOL) strict  requiredKeys:(NSArray*) requiredKeys;


@end