//
//	FLStringUtilities.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLStringUtilities.h"
#import "NSString+FLCore.h"


@implementation NSString (FLStringUtilities)

- (NSString*) stringWithUpperCaseFirstLetter
{
	return [NSString stringWithFormat:@"%c%@", 
					toupper([self characterAtIndex:0]),
					[self substringFromIndex:1]];
}

- (NSString*) stringWithLowercaseFirstLetter
{
	return [NSString stringWithFormat:@"%c%@", 
			tolower([self characterAtIndex:0]),
			[self substringFromIndex:1]];
}


- (NSString*) camelCaseSpaceDelimitedString
{
	NSArray* split = [self componentsSeparatedByString:@" "];
	
	NSMutableString* outString = [NSMutableString string];
	
	[outString appendString:[split objectAtIndex:0]];
	
	for(NSUInteger i = 1; i < split.count; i++)
	{
		[outString appendString:[[split objectAtIndex:i] stringWithUpperCaseFirstLetter]];
	}
	
	return outString;
}

+ (BOOL) linesAreEqual:(NSArray*) lhs 
	rhs:(NSArray*) rhs 
	startString:(NSString*) startString
	lhsName:(NSString*) lhsName
	rhsName:(NSString*) rhsName
	output:(FLStringBuilder*) output 
{
	if(!output && lhs.count != rhs.count) {
		return NO;
	}
	
	BOOL started = startString == nil;
	BOOL outputHeader = NO;
    BOOL areSame = YES;

	NSUInteger numLines = MIN(lhs.count, rhs.count);
    
	for(NSUInteger i = 0; i < numLines; i++) {
		NSString* lhsStr = [lhs objectAtIndex:i];
		NSString* rhsStr = [rhs objectAtIndex:i];
		
		if(!started) {
			if([lhsStr rangeOfString:startString].length > 0) {
				started = YES;
			}
		} else if(![lhsStr isEqualToString:rhsStr]) {
			if(output) {
				areSame = NO;
				if(!outputHeader) {
					outputHeader = YES;
					[output appendLine:@"Comparison between:"];
					[output indent];
					[output appendLine:lhsName];
					[output appendLine:rhsName];
					[output undent];
				}
			
				[output indent];
				[output appendLine:@"Lines are different:"];
				[output indent];
				[output appendLineWithFormat:@"'%@'", lhsStr];
				[output appendLineWithFormat:@"'%@'", rhsStr];
				[output undent];
				[output undent];
            }
			else {
				return NO;
			}
		}
	}
	
	if(lhs.count != rhs.count) {
		if(output) {
            if(!outputHeader) {
            //	outputHeader = YES;
                [output appendLine:@"Comparison between:"];
                [output indent];
                [output appendLine:lhsName];
                [output appendLine:rhsName];
                [output undent];
            }
            [output indent];
                    
            if(lhs.count > rhs.count) {
                [output appendLineWithFormat: @"lines not in %@:", rhsName];
                [output indent];
                for(NSUInteger i = rhs.count; i < lhs.count; i++){
                    [output appendLineWithFormat:@"%@", [lhs objectAtIndex:i]];
                }
                [output undent];
            } else if(rhs.count > lhs.count) {
                [output appendLineWithFormat: @"lines not in %@:", lhsName];
                [output indent];
                for(NSUInteger i = lhs.count; i < rhs.count; i++) {
                    [output appendLineWithFormat:@"%@", [rhs objectAtIndex:i]];
                }
                [output undent];
            }
            [output undent];
		}
		areSame = NO;
	}
	
	return areSame;
}

- (BOOL) linesAreEqualTo:(NSString*) otherString 
	startString:(NSString*) startString
	lhsName:(NSString*) lhsName
	rhsName:(NSString*) rhsName
	output:(FLStringBuilder*) output {
	return [NSString linesAreEqual:[self lines] rhs:[otherString lines] startString:startString lhsName:lhsName rhsName:rhsName output:output];
} 

- (NSString*) trimmedStringWithNoLFCR
{
	NSString* str = [self trimmedString];
	str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
	return [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

#define KB 1024.0
#define MB (1024.0*1024.0)
#define GB (1024.0*1024.0*1024.0)

+ (NSString*) stringWithByteSize:(unsigned long long) byteSize
{
	CGFloat value = 0.0;
	 
	NSString* type = nil; 
	if(byteSize >= FLGigabytes)
	{	
		type = NSLocalizedString(@"GB", nil);
		value = FLBytesToGigabytes(byteSize);
	}
	else if(byteSize >= FLMegabtyes)
	{
		type = NSLocalizedString(@"MB", nil);
		value = FLBytesToMegabytes(byteSize);
	}
	else if(byteSize >= FLKilobytes)
	{
		type = NSLocalizedString(@"KB", nil);
		value = FLBytesToKilobytes(byteSize);
	}
	else
	{
		return [NSString stringWithFormat:@"%.0f B", (float) byteSize];
	}

	value += 0.005; // round up to the hundreth
	return [NSString stringWithFormat:@"%.1f %@", value, type];
}

// TODO: is there a better way to do this?
- (NSString*) trimmedString {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString*) stringWithPadding:(NSUInteger) width {
    NSMutableString* str = [NSMutableString stringWithString:self];
    for(NSUInteger i = self.length; i < width; i++) {
        [str appendString:@" "];
    }
    return str;
}


@end




/*
#if DEBUG
@implementation FLDebugString

FLSynthesizeStructProperty(logLifetime, setLogLifetime, BOOL, _stringFlags);
FLSynthesizeStructProperty(trackDeletes, setTrackDeletes, BOOL, _stringFlags);

- (id) init
{
	if((self = [super init]))
	{
		_string = @"";
		_retainCount = 1;
	}
	
	return self;
}

- (id)initWithString:(NSString *)aString
{
	if((self = [super init]))
	{
		_string = [aString copy];
		_retainCount = 1;	  
	}
	return self;
}

- (id)initWithData:(NSData *)data encoding:(NSStringEncoding)encoding
{
	if((self = [super init]))
	{
		_string = [[NSString alloc] initWithData:data encoding:encoding];
		_retainCount = 1;	  
	}
	return self;
}

+ (id)string
{
	return FLReturnAutoreleased([[FLDebugString alloc] init]);
}

+ (id)stringWithString:(NSString *)string
{
	return FLReturnAutoreleased([[FLDebugString alloc] initWithString:string]);
}

- (NSUInteger) retainCount
{
	if(self.trackDeletes)
	{
		return 1;
	}

	return [super retainCount];
}

- (NSInteger) debugRetainCount
{
	return self.trackDeletes ? _retainCount : (NSInteger) self.retainCount;
}

- (void) dealloc
{
	if(self.logLifetime)
	{
		FLDebugLog(@"%X: String \"%@\" dealloc. Retain Count: %d", (void*) self, [NSString stringWithString:_string], self.retainCount);
	}

	FLReleaseWithNil(_string);
	FLSuperDealloc();
}

- (id)retain
{
	if(self.logLifetime)
	{
		FLDebugLog(@"%X: String \"%@\" retain. Retain Count before retain: %d", (void*) self, [NSString stringWithString:_string], self.debugRetainCount);
	}

	FLAssert(_retainCount > 0, @"invalid retain count");

	++_retainCount;
	
	if(self.trackDeletes)
	{
		return self;
	}

	return [super retain];
}

- (oneway void)release
{
	if(self.logLifetime)
	{
		FLDebugLog(@"%X: String \"%@\" release. Retain Count before release: %d", (void*) self, [NSString stringWithString:_string], self.debugRetainCount);
	}

	FLAssert(_retainCount > 0, @"invalid retain count");

	--_retainCount;
	
	if(!self.trackDeletes)
	{
		[super release];
	}
}
- (id)autorelease
{
	if(self.logLifetime)
	{
		FLDebugLog(@"%X: String \"%@\" autorelease. Retain Count: %d",(void*) self, [NSString stringWithString:_string], self.debugRetainCount);
	}

	FLAssert(_retainCount > 0, @"invalid retain count");

	return [super autorelease];
}

- (NSUInteger)length
{
	return _string.length;
}

- (unichar)characterAtIndex:(NSUInteger)idx
{
	return [_string characterAtIndex:idx];
}

- (struct stringFlags) flags
{
	return _stringFlags;
}

- (void) setFlags:(struct stringFlags) flags
{
	_stringFlags = flags;
}

- (NSString*) setLogFlag:(FLDebugString*) string
{
	string.flags = self.flags;
	return string;
} 

- (NSString *)stringByTrimmingCharactersInSet:(NSCharacterSet *)set
{
	return [self setLogFlag:[FLDebugString stringWithString:[_string stringByTrimmingCharactersInSet:set]]];
}

- (NSString *)stringByPaddingToLength:(NSUInteger)newLength withString:(NSString *)padString startingAtIndex:(NSUInteger)padIndex
{
	return [self setLogFlag:[FLDebugString stringWithString:[_string stringByPaddingToLength:newLength withString:padString startingAtIndex:padIndex]]];
}



@end 
#endif
*/
