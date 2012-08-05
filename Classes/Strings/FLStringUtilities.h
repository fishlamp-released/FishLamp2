//
//	FLStringUtilities.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLStringBuilder.h"
#import "NSString+Lists.h"

typedef void (^FLStringCallback)(NSString* string);


@interface NSString (FLStringUtilities)

- (NSString*) stringWithUpperCaseFirstLetter;
- (NSString*) stringWithLowercaseFirstLetter;

- (NSString*) camelCaseSpaceDelimitedString;

- (NSString*) trimmedStringWithNoLFCR;

+ (BOOL) linesAreEqual:(NSArray*) lhs 
	rhs:(NSArray*) rhs 
	startString:(NSString*) startString
	lhsName:(NSString*) lhsName
	rhsName:(NSString*) rhsName
	output:(FLStringBuilder*) output;
	
- (BOOL) linesAreEqualTo:(NSString*) otherString 
	startString:(NSString*) startString
	lhsName:(NSString*) lhsName
	rhsName:(NSString*) rhsName
	output:(FLStringBuilder*) output;

+ (NSString*) stringWithByteSize:(unsigned long long) byteSize;

- (NSString*) trimmedString;

- (NSString*) stringWithPadding:(NSUInteger) width;

@end


// TODO: move these somewhere more sensible.
#define FLKilobytes 1024.0
#define FLMegabtyes 1048576.0
#define FLGigabytes 1073741824.0

#define FLBytesToKilobytes(__bytes__) (((CGFloat)(__bytes__)) / FLKilobytes)
#define FLBytesToMegabytes(__bytes__) (((CGFloat)(__bytes__)) / FLMegabtyes)
#define FLBytesToGigabytes(__bytes__) (((CGFloat)(__bytes__)) / FLGigabytes)


/*
#if DEBUG

@interface FLDebugString : NSString {
	NSString* _string;
	struct stringFlags {
		unsigned int logLifetime:1;
		unsigned int trackDeletes:1;
	} _stringFlags;
	NSInteger _retainCount;
}

@property (readwrite, assign, nonatomic) BOOL logLifetime;
@property (readwrite, assign, nonatomic) BOOL trackDeletes;

- (id)init;
- (id)initWithString:(NSString *)aString;
- (id)initWithData:(NSData *)data encoding:(NSStringEncoding)encoding;

+ (id)string;
+ (id)stringWithString:(NSString *)string;

- (NSString *)stringByTrimmingCharactersInSet:(NSCharacterSet *)set;
- (NSString *)stringByPaddingToLength:(NSUInteger)newLength withString:(NSString *)padString startingAtIndex:(NSUInteger)padIndex;

@end

//#define FLString FLDebugString
//
//#define FLStringRef(__str__) ((FLDebugString*) __str__)
//
//#else
//
//#define FLString NSString
//
#endif
*/
