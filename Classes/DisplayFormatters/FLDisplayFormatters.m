//
//	FLKeywordListFormatter.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLDisplayFormatters.h"
#import "FLStringUtilities.h"
#import "FLHtmlBuilder.h"

@implementation FLKeywordListFormatter

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

@implementation FLStringFormatter

+ (NSString*) displayFormatterDataToString:(id) data; 
{
	return data;
}

+ (id) displayFormatterStringToData:(NSString*) string
{
	return string;
}

@end

@implementation NSString (FLDisplayFormatter)

- (NSString*) formattedStringForDisplay
{
    return self;
}

@end

@implementation FLIntFormatter

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



@implementation FLLongFormatter

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

@implementation FLDateFormatter

FLSynthesizeSingleton(FLDateFormatter)

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
//		FLLogAssert([data timeIntervalSinceReferenceDate] != 0, @"date is zero");
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


@implementation FLBytesDataSizeFormatter

+ (NSString*) displayFormatterDataToString:(id) data
{
	 return data ? [NSString stringWithByteSize:[data unsignedLongLongValue]] : @"";
}

+ (id) displayFormatterStringToData:(NSString*) string
{
	FLAssert(NO, @"not supported");
	return nil;
}

@end

@implementation FLKilobytesDataSizeFormatter

+ (NSString*) displayFormatterDataToString:(id) data
{
	return data ? [super displayFormatterDataToString:[NSNumber numberWithUnsignedLongLong:[data unsignedLongLongValue] * 1024]]: @"";
}
@end


@implementation FLObjectDescriptionFormatter

+ (NSString*) displayFormatterDataToString:(id) data
{
	return [data description];
}

+ (id) displayFormatterStringToData:(NSString*) string
{
	FLAssert(NO, @"not supported");
	return nil;
}

@end

@implementation FLSimpleHtmlFormatter

+ (NSString*) displayFormatterDataToString:(id) data
{
	return [FLHtmlBuilder convertFromSimpleHtml:data];
}

+ (id) displayFormatterStringToData:(NSString*) string
{
	return [FLHtmlBuilder convertToSimpleHtml:string];
}

@end

@implementation FLStringListFormatter

+ (NSString*) displayFormatterDataToString:(id) data
{
	return [NSString concatStringArray:data];
}

+ (id) displayFormatterStringToData:(NSString*) string
{
	return [string splitDelimitedOrQuotedString];
}

@end
 

