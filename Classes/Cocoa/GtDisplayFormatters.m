//
//	GtKeywordListFormatter.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtDisplayFormatters.h"
#import "GtStringUtils.h"
#import "GtHtmlBuilder.h"

@implementation GtKeywordListFormatter

+ (NSString*) concatStringArray:(NSArray*) array
{
	if(array)
	{
		NSMutableString* outStr = [NSMutableString stringWithString:@""];
			
		for(NSString* str in array)
		{
			[outStr appendFormat:@"%@%@", (([outStr length] > 0) ? @", " : @""), str];
		}

		return outStr;
	}
	return @"";
}

+ (NSString*) displayFormatterDataToString:(id) data
{
	if(data)
	{
		if([data isKindOfClass:[NSArray class]])
		{
			NSMutableString* outStr = [NSMutableString stringWithString:@""];
				
			for(NSString* str in data)
			{
				NSString* value = ([str rangeOfString:@" "].length > 0) ? 
					[NSString stringWithFormat:@"\"%@\"", str] :
					str;
			
				[outStr appendFormat:@"%@%@", (([outStr length] > 0) ? @", " : @""), value] ;
			}

			return outStr;
		}
	}
	return @"";
}

+ (id) displayFormatterStringToData:(NSString*) string
{
	return [string splitDelimitedOrQuotedString];
}


@end

@implementation GtStringFormatter

+ (NSString*) displayFormatterDataToString:(id) data; 
{
	return data;
}

+ (id) displayFormatterStringToData:(NSString*) string
{
	return string;
}

@end

@implementation NSString (GtDisplayFormatter)

- (NSString*) formattedStringForDisplay
{
    return self;
}

@end

@implementation GtIntFormatter

+ (NSString*) displayFormatterDataToString:(id) data; 
{
	NSNumber* num =	 data == nil ? [NSNumber numberWithInt:0] : data;

	return [NSString stringWithFormat:@"%@",num];
}

+ (id) displayFormatterStringToData:(NSString*) string
{
	return [NSNumber numberWithInt:[string intValue]];
}

@end



@implementation GtLongFormatter

+ (NSString*) displayFormatterDataToString:(id) data; 
{
	NSNumber* num =	 data == nil ? [NSNumber numberWithInt:0] : data;

	return [NSString stringWithFormat:@"%@", num];
}

+ (id) displayFormatterStringToData:(NSString*) string
{
	return [NSNumber numberWithLong:[string intValue]];
}

@end

@implementation GtDateFormatter

GtSynthesizeSingleton(GtDateFormatter)

static NSDateFormatter* s_formatter = nil;

+ (void) initialize
{
	if(!s_formatter)
	{
		s_formatter = [[NSDateFormatter alloc] init];
		[s_formatter setDateStyle:kCFDateFormatterShortStyle];
		[s_formatter setTimeStyle:kCFDateFormatterShortStyle];
	}
}

+ (NSString*) displayFormatterDataToString:(id) data
{
	if([data isKindOfClass:[NSDate class]])
	{
		GtLogAssert([data timeIntervalSinceReferenceDate] != 0, @"date is zero");
		return [s_formatter stringFromDate:data]; 
	}
	
	return data;
}

+ (id) displayFormatterStringToData:(NSString*) string
{
// TODO: a number? why not a date?
	return [NSNumber numberWithInt:[string intValue]];
}

@end


@implementation GtBytesDataSizeFormatter

+ (NSString*) displayFormatterDataToString:(id) data
{
	 return data ? [NSString stringWithByteSize:[data unsignedLongLongValue]] : @"";
}

+ (id) displayFormatterStringToData:(NSString*) string
{
	GtAssert(NO, @"not supported");
	return nil;
}

@end

@implementation GtKilobytesDataSizeFormatter

+ (NSString*) displayFormatterDataToString:(id) data
{
	return data ? [super displayFormatterDataToString:[NSNumber numberWithUnsignedLongLong:[data unsignedLongLongValue] * 1024]]: @"";
}
@end


@implementation GtObjectDescriptionFormatter

+ (NSString*) displayFormatterDataToString:(id) data
{
	return [data description];
}

+ (id) displayFormatterStringToData:(NSString*) string
{
	GtAssert(NO, @"not supported");
	return nil;
}

@end

@implementation GtSimpleHtmlFormatter

+ (NSString*) displayFormatterDataToString:(id) data
{
	return [GtHtmlBuilder convertFromSimpleHtml:data];
}

+ (id) displayFormatterStringToData:(NSString*) string
{
	return [GtHtmlBuilder convertToSimpleHtml:string];
}

@end

@implementation GtStringListFormatter

+ (NSString*) displayFormatterDataToString:(id) data
{
	return [NSString concatStringArray:data];
}

+ (id) displayFormatterStringToData:(NSString*) string
{
	return [string splitDelimitedOrQuotedString];
}

@end
 

