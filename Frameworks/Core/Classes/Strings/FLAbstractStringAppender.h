//
//  FLAbstractStringAppender.h
//  FishLampCore
//
//  Created by Mike Fullerton on 8/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCoreRequired.h"

@interface FLAbstractStringAppender : NSObject

/**
    Required overrides
 */
- (void) appendString:(NSString*) string;

- (void) closeLineWithString:(NSString*) string;

- (void) openLineWithString:(NSString*) string;

- (void) appendLine:(NSString*) string;


/**
    These call required overrides
 */

- (void) appendLines:(NSString**) lines
               count:(NSInteger) count;

- (void) appendLines:(NSString**) lines ;

- (void) appendLinesWithArray:(NSArray*) lines ;

- (void) appendFormat:(NSString*) format, ... ;

- (void) appendFormat:(NSString*) format arguments:(va_list)argList;

- (void) appendLineWithFormat:(NSString*) format, ... ;

- (void) appendLineWithFormat:(NSString*) format arguments:(va_list)argList ;

- (void) openLineWithFormat:(NSString*) format, ... ;

- (void) closeLineWithFormat:(NSString*) format, ... ;

- (void) appendStringContainingMultipleLines:(NSString*) inLines 
                              trimWhitespace:(BOOL) trimWhitespace ;

- (void) appendStringContainingMultipleLines:(NSString*) inLines;

@end




