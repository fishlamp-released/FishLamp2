//
//	NSString+Lists.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/13/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"


@interface NSString (Lists)

+ (NSString*) concatStringArray:(NSArray*) array;// delimits with ", "
+ (NSString*) concatStringArray:(NSArray*) array withDelim:(NSString*) delim;

// delimited by space or comma, quoted strings can have spaces or commas, unterminated quote
// causes leading quote to be igored.
- (NSMutableArray*) splitDelimitedOrQuotedString;
 
// bust out lines "asdf/nasdf/n"
- (NSArray*) lines;

- (NSString*) stringByAddingUniqueWord:(NSString*) word; // adds the word if it's not already there.
- (NSString*) stringByRemovingUniqueWord:(NSString*) word;
@end

