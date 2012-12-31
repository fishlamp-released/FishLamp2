//
//	FLKeywordListFormatter.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLDisplayFormatters.h"
#import "FLStringUtils.h"
#import "FLHtmlStringBuilder.h"
#import "NSString+Lists.h"

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

@implementation FLStringDisplayFormatter

+ (NSString*) displayFormatterDataToString:(id) data
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

+ (NSString*) displayFormatterDataToString:(id) data
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

+ (NSString*) displayFormatterDataToString:(id) data {
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

+ (void) initialize {
	if(!s_formatter) {
		s_formatter = [[NSDateFormatter alloc] init];
		[s_formatter setDateStyle:kCFDateFormatterShortStyle];
		[s_formatter setTimeStyle:kCFDateFormatterShortStyle];
	}
}

+ (NSString*) displayFormatterDataToString:(id) data {
	if([data isKindOfClass:[NSDate class]]) {
//		FLLogAssert([data timeIntervalSinceReferenceDate] != 0, @"date is zero");
		return [s_formatter stringFromDate:data]; 
	}
	
	return data;
}

+ (id) displayFormatterStringToData:(NSString*) string {
// TODO: a number? why not a date?
	return [NSNumber numberWithInt:[string intValue]];
}

@end


@implementation FLBytesDataSizeFormatter

+ (NSString*) displayFormatterDataToString:(id) data {
	 return data ? FLStringFromByteSize([data unsignedLongLongValue]) : @"";
}

+ (id) displayFormatterStringToData:(NSString*) string {
	FLAssert_v(NO, @"not supported");
	return nil;
}

@end

@implementation FLKilobytesDataSizeFormatter

+ (NSString*) displayFormatterDataToString:(id) data {
	return data ? [super displayFormatterDataToString:[NSNumber numberWithUnsignedLongLong:[data unsignedLongLongValue] * 1024]]: @"";
}
@end


@implementation FLObjectDescriptionFormatter

+ (NSString*) displayFormatterDataToString:(id) data {
	return [data description];
}

+ (id) displayFormatterStringToData:(NSString*) string {
	FLAssert_v(NO, @"not supported");
	return nil;
}

@end

@implementation FLSimpleHtmlFormatter

+ (NSString*) displayFormatterDataToString:(id) data {
	return [FLHtmlStringBuilder convertHtmlBreaksToNewlines:data];
}

+ (id) displayFormatterStringToData:(NSString*) string {
	return [FLHtmlStringBuilder convertNewlinesToHtmlBreaks:string];
}

@end

@implementation FLStringListFormatter

+ (NSString*) displayFormatterDataToString:(id) data {
	return [NSString concatStringArray:data];
}

+ (id) displayFormatterStringToData:(NSString*) string {
	return [string splitDelimitedOrQuotedString];
}

@end

#define KB 1024.0
#define MB (1024.0*1024.0)
#define GB (1024.0*1024.0*1024.0)

NSString* FLStringFromByteSize(unsigned long long byteSize)
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

