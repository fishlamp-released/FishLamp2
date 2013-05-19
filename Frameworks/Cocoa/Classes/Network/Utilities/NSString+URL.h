//
//  NSString+URL.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/18/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

@interface NSString (URL)

+ (NSString*) URLString:(NSString*) url params:(NSString*) firstParameter, ...  NS_REQUIRES_NIL_TERMINATION;

- (NSString*) appendURLParameters:(NSString*) firstParameter, ...  NS_REQUIRES_NIL_TERMINATION;

- (NSString *) urlEncodeString:(NSStringEncoding)encoding;
- (NSString *) urlDecodeString:(NSStringEncoding) encoding;

+ (NSDictionary*) parseURLParams:(NSString *)query;


@end

@interface NSMutableString (URL)

- (void) appendAndEncodeURLParameter:(NSString*) parameter name:(NSString*)name seperator:(NSString*) seperator; 
	// eg [str appendAndEncodeURLParameter:@"mike" name:@"username" seperator:@"&"];

@end