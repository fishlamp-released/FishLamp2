//
//  GtStringUtils.m
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtStringUtils.h"

#if DEBUG
#include "_FLStringUtils.h"
#endif 

NSString* GtStringWithFormatOrNil(NSString* format, ...) {
    if(format) {
        va_list va;
        va_start(va, format);
        NSString* string = GtReturnAutoreleased([[NSMutableString alloc] initWithFormat:format arguments:va]);
        va_end(va);
        return string;
    }
    
    return @"";
}

//
//	GtStringUtils.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtStringUtils.h"



@implementation NSString (GtStringUtils)

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

- (NSString*) trimmedStringWithNoLFCR
{
	NSString* str = [self trimmedString];
	str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
	return [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

+ (NSString*) stringWithByteSize:(unsigned long long) byteSize
{
//	float value = 0.0;

// FIXME	 
//	NSString* type = nil; 
//	if(byteSize >= GtGigabytes)
//	{	
//		type = NSLocalizedString(@"GB", nil);
//		value = GtBytesToGigabytes(byteSize);
//	}
//	else if(byteSize >= GtMegabtyes)
//	{
//		type = NSLocalizedString(@"MB", nil);
//		value = GtBytesToMegabytes(byteSize);
//	}
//	else if(byteSize >= GtKilobytes)
//	{
//		type = NSLocalizedString(@"KB", nil);
//		value = GtBytesToKilobytes(byteSize);
//	}
//	else
//	{
//		return [NSString stringWithFormat:@"%.0f B", (float) byteSize];
//	}

//	value += 0.005; // round up to the hundreth
//	return [NSString stringWithFormat:@"%.1f %@", value, type];

    return nil;
}

@end

extern NSString* GtStringWithFormat(NSString* format, ...); 

NSString *GtStringWithFormat(NSString *format, ...) 
{
	va_list va;
	va_start(va, format);
	NSString* string = GtReturnAutoreleased([[NSMutableString alloc] initWithFormat:format arguments:va]);
	va_end(va);
	
	return string;
}

/*
#if DEBUG
@implementation GtDebugString

GtSynthesizeStructProperty(logLifetime, setLogLifetime, BOOL, m_stringFlags);
GtSynthesizeStructProperty(trackDeletes, setTrackDeletes, BOOL, m_stringFlags);

- (id) init
{
	if((self = [super init]))
	{
		m_string = @"";
		m_retainCount = 1;
	}
	
	return self;
}

- (id)initWithString:(NSString *)aString
{
	if((self = [super init]))
	{
		m_string = [aString copy];
		m_retainCount = 1;	  
	}
	return self;
}

- (id)initWithData:(NSData *)data encoding:(NSStringEncoding)encoding
{
	if((self = [super init]))
	{
		m_string = [[NSString alloc] initWithData:data encoding:encoding];
		m_retainCount = 1;	  
	}
	return self;
}

+ (id)string
{
	return GtReturnAutoreleased([[GtDebugString alloc] init]);
}

+ (id)stringWithString:(NSString *)string
{
	return GtReturnAutoreleased([[GtDebugString alloc] initWithString:string]);
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
	return self.trackDeletes ? m_retainCount : (NSInteger) self.retainCount;
}

- (void) dealloc
{
	if(self.logLifetime)
	{
		GtLog(@"%X: String \"%@\" dealloc. Retain Count: %d", (void*) self, [NSString stringWithString:m_string], self.retainCount);
	}

	GtReleaseWithNil(m_string);
	GtSuperDealloc();
}

- (id)retain
{
	if(self.logLifetime)
	{
		GtLog(@"%X: String \"%@\" retain. Retain Count before retain: %d", (void*) self, [NSString stringWithString:m_string], self.debugRetainCount);
	}

	GtAssert(m_retainCount > 0, @"invalid retain count");

	++m_retainCount;
	
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
		GtLog(@"%X: String \"%@\" release. Retain Count before release: %d", (void*) self, [NSString stringWithString:m_string], self.debugRetainCount);
	}

	GtAssert(m_retainCount > 0, @"invalid retain count");

	--m_retainCount;
	
	if(!self.trackDeletes)
	{
		[super release];
	}
}
- (id)autorelease
{
	if(self.logLifetime)
	{
		GtLog(@"%X: String \"%@\" autorelease. Retain Count: %d",(void*) self, [NSString stringWithString:m_string], self.debugRetainCount);
	}

	GtAssert(m_retainCount > 0, @"invalid retain count");

	return [super autorelease];
}

- (NSUInteger)length
{
	return m_string.length;
}

- (unichar)characterAtIndex:(NSUInteger)idx
{
	return [m_string characterAtIndex:idx];
}

- (struct stringFlags) flags
{
	return m_stringFlags;
}

- (void) setFlags:(struct stringFlags) flags
{
	m_stringFlags = flags;
}

- (NSString*) setLogFlag:(GtDebugString*) string
{
	string.flags = self.flags;
	return string;
} 

- (NSString *)stringByTrimmingCharactersInSet:(NSCharacterSet *)set
{
	return [self setLogFlag:[GtDebugString stringWithString:[m_string stringByTrimmingCharactersInSet:set]]];
}

- (NSString *)stringByPaddingToLength:(NSUInteger)newLength withString:(NSString *)padString startingAtIndex:(NSUInteger)padIndex
{
	return [self setLogFlag:[GtDebugString stringWithString:[m_string stringByPaddingToLength:newLength withString:padString startingAtIndex:padIndex]]];
}



@end 
#endif
*/
