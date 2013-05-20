//
//	NSString+Lists.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/13/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSString+Lists.h"
#import "NSString+GtExtras.h"

@implementation NSString (Lists)

- (BOOL) isQuote:(unichar) c
{
	return c == '\"' || c == '\'';
}

- (BOOL) isDelimeter:(unichar) c
{
	return c == ' ' || c == ',' || c == '\n' || c == '\r' || [self isQuote:c];
}


+ (NSString*) concatStringArray:(NSArray*) array
{
	return [NSString concatStringArray:array withDelim:@", "];
}

+ (NSString*) concatStringArray:(NSArray*) array withDelim:(NSString*) delim
{
	if(array)
	{
		NSMutableString* outStr = [NSMutableString stringWithString:@""];
			
		for(NSString* str in array)
		{
			[outStr appendFormat:@"%@%@", (([outStr length] > 0) ? delim : @""), str];
		}

		return outStr;
	}
	return @"";
}

- (NSMutableArray*) splitDelimitedOrQuotedString
{
	NSString* value = self;

	NSMutableArray* newArray = [NSMutableArray array];
	
	NSUInteger len = [value length];
	
	for(NSUInteger i = 0; i < len; i++)
	{
		unichar c = [value characterAtIndex:i];
		if([self isQuote:c])
		{
			for(NSUInteger y = i + 1; y < len; y++)
			{
				if([value characterAtIndex:y] == c)
				{
					++i;
					
					[newArray addObject:
						[NSString stringWithString:
							[value substringWithRange:NSMakeRange(i, y - i)]]];
					i = y;
					break;
				}
			}
		}
		else if([self isDelimeter:c])
		{
			continue;
		}
		else
		{
			for(NSUInteger y = i + 1; y < len; y++)
			{
			
				if([self isDelimeter:[value characterAtIndex:y]])
				{
					NSString* str = 
						[[NSString alloc] initWithString:
							[value substringWithRange:NSMakeRange(i, y - i)]];
					[newArray addObject:str];
					GtRelease(str);
					i = y;
					break;
				}
				else if((y+1) == len)
				{
					NSString* str = 
						[[NSString alloc] initWithString:
							[value substringWithRange:NSMakeRange(i, y - i + 1)]];
					[newArray addObject:str];
					GtRelease(str);
					i = y;
					
				}
			}

		}
	}
	

	return newArray;
} 

- (NSArray*) lines
{
	NSString* string = [self stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
	return [string componentsSeparatedByString:@"\n"];
}

- (NSString*) stringByAddingUniqueWord:(NSString*) word
{
	NSArray* splitString = [self componentsSeparatedByString:@" "];
	for(NSString* item in splitString)
	{
		if(GtStringsAreEqual(word, item))
		{
			return GtReturnAutoreleased(GtReturnRetained(self));
		}
	}
	if(self.length)
	{
		return [self stringByAppendingFormat:@" %@", word];
	}
   
	return GtReturnAutoreleased(GtReturnRetained(word));
}

- (NSString*) stringByRemovingUniqueWord:(NSString*) word
{
	NSString* string = [self stringByReplacingOccurrencesOfString:word withString:@""];
	return [string trimmedString];
}
@end
