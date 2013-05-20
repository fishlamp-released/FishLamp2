//
//  GtKeywordListFormatter.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/13/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtDisplayFormatters.h"

#import "GtObjectArray.h"
#import "GtComplexObjectArray.h"
#import "GtStringUtilities.h"
#import "GtHtmlBuilder.h"

@implementation GtKeywordListFormatter

- (NSString*) concatStringArray:(NSArray*) array
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

- (NSString*) dataToString:(id) data
{
	if(data)
	{
		NSMutableString* outStr = [NSMutableString stringWithString:@""];
			
		for(NSString* str in [data array])
		{
			NSString* value = ([str rangeOfString:@" "].length > 0) ? 
				[NSString stringWithFormat:@"\"%@\"", str] :
				str;
		
			[outStr appendFormat:@"%@%@", (([outStr length] > 0) ? @", " : @""), value] ;
		}

		return outStr;
	}
	return @"";
}

- (id) stringToData:(NSString*) string prevData:(id) prevData
{
	GtComplexObjectArray* new = nil;
	if(prevData)
	{
		new = [[prevData copy] autorelease];
	//	 [[[GtComplexObjectArray alloc] initAsCopy:prevData] autorelease];
	}
	else
	{
		new = [[GtAlloc(GtComplexObjectArray) init] autorelease];
	}
	new.array = [string splitDelimitedOrQuotedString];
	return new;
}


@end

@implementation GtStringFormatter

- (NSString*) dataToString:(id) data; // TODO: add to category
{
	return data;
}

- (id) stringToData:(NSString*) string prevData:(id) prevData
{
	return string;
}

@end

@implementation GtIntFormatter

- (NSString*) dataToString:(id) data; // TODO: add to category
{
	NSNumber* num =  data == nil ? [NSNumber numberWithInt:0] : data;

	return [NSString stringWithFormat:@"%@",num];
}

- (id) stringToData:(NSString*) string prevData:(id) prevData;
{
	return [NSNumber numberWithInt:[string intValue]];
}

@end

@implementation GtLongFormatter

- (NSString*) dataToString:(id) data; // TODO: add to category
{
	NSNumber* num =  data == nil ? [NSNumber numberWithInt:0] : data;

	return [NSString stringWithFormat:@"%@", num];
}

- (id) stringToData:(NSString*) string prevData:(id) prevData;
{
	return [NSNumber numberWithLong:[string intValue]];
}

@end

@implementation GtDateFormatter

GtSynthesizeSingleton(GtDateFormatter)

- (id) init
{
    if(self = [super init])
    {
        m_dateFormatter = [GtAlloc(NSDateFormatter) init];
        [m_dateFormatter setDateStyle:kCFDateFormatterShortStyle];
        [m_dateFormatter setTimeStyle:kCFDateFormatterShortStyle];
    }
    
    return self;
}

- (void) dealloc
{
    GtRelease(m_dateFormatter);
    [super dealloc];
}

- (NSString*) dataToString:(id) data; // TODO: add to category
{
    return [m_dateFormatter stringFromDate:data]; 
}

- (id) stringToData:(NSString*) string prevData:(id) prevData
{
// TODO: a number? why not a date?
	return [NSNumber numberWithInt:[string intValue]];
}

@end


@implementation GtBytesDataSizeFormatter

#define KB 1024.0
#define MB (1024.0*1024.0)
#define GB (1024.0*1024.0*1024.0)

- (NSString*) dataToString:(id) data
{
	 unsigned long long num = [data unsignedLongLongValue];
	 float value = 0.0;
	 
	 if(num == 0)
	 {
		return @"0 KB";
	 }
	 
	 NSString* type = @" KB";
	 if(num >= GB)
	 {	
		type = @" GB";
		value = num / GB;
	 }
	 else if(num >= MB)
	 {
		type = @" MB";
	 	value = num / MB;
	 }
	 else 
	 {
		value = num / KB;
	 }
	 
	 value += 0.05;
	 
	 return [NSString stringWithFormat:@"%.1f%@", value, type];
}

- (id) stringToData:(NSString*) string prevData:(id) prevData
{
	GtAssert(NO, @"not supported");
	return nil;
}

@end

@implementation GtKilobytesDataSizeFormatter

- (unsigned long long) startingNumberFromData:(id) data
{
	return [data unsignedLongValue] * 1024;
}
@end


@implementation GtObjectDescriptionFormatter

- (NSString*) dataToString:(id) data
{
	return [data description];
}

- (id) stringToData:(NSString*) string prevData:(id) prevData
{
	GtAssert(NO, @"not supported");
	return nil;
}

@end

@implementation GtSimpleHtmlFormatter

- (NSString*) dataToString:(id) data
{
	return [GtHtmlBuilder convertFromSimpleHtml:data];
}

- (id) stringToData:(NSString*) string prevData:(id) prevData
{
	return [GtHtmlBuilder convertToSimpleHtml:string];
}

@end


 

