//
//  GtUrlParameterParser.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/3/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtUrlParameterParser.h"
#import "NSString+URL.h"

@implementation GtUrlParameterParser

+ (BOOL) _setDataInObject:(id) object key:(NSString*) key data:(id) data strict:(BOOL)strict
{
//	GtObjectDescriber* describer = [[object class] sharedObjectDescriber];
//	GtAssertNotNil(describer);
//
//	GtPropertyDescription* desc = [describer propertyDescriberForPropertyName:key];
//	GtAssertNotNil(desc);

	@try
	{
		[object setValue:data forKey:key];
		return YES;
	}
	@catch(NSException* ex)
	{
	
	}

	if(strict)
	{
		GtThrowErrorCode(GtUrlParamenterParserErrorDomain, GtUrlParameterParserErrorCodeUnexpectedData, ([NSString stringWithFormat:@"GtUrlParameterParser got unexpected data for key: %@", key]));
	}
	else
	{
		GtLog(@"GtUrlParameterParser skipped data (not in dest object): %@=%@", key, data);
	}
	
	return NO;
}

+ (BOOL) parseString:(NSString*) string intoObject:(id) object  strict:(BOOL) strict
{
	BOOL gotItAll = YES;
	NSDictionary* values = [NSString parseURLParams:string];
	for(NSString* key in values)
	{
		if(![GtUrlParameterParser _setDataInObject:object key:key data:[values objectForKey:key] strict:strict])
		{
			gotItAll = NO;
		}
	}
	
	return gotItAll;
}

+ (BOOL) parseData:(NSData*) data intoObject:(id) object strict:(BOOL) strict
{
	return [GtUrlParameterParser parseString:GtReturnAutoreleased([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]) intoObject:object strict:strict];
}

+ (BOOL) parseString:(NSString*) string intoObject:(id) object strict:(BOOL) strict requiredKeys:(NSArray*) requiredKeys
{
	BOOL gotItAll = YES;
	NSMutableDictionary* values = GtReturnAutoreleased([[NSString parseURLParams:string] mutableCopy]);
	
	for(NSString* key in requiredKeys)
	{
		id data = [values objectForKey:key];
		if(data)
		{
			if(![GtUrlParameterParser _setDataInObject:object key:key data:data strict:strict])
			{
				gotItAll = NO;
			}
			[values removeObjectForKey:key];	
		}
		else
		{
			GtThrowErrorCode(GtUrlParamenterParserErrorDomain, GtUrlParameterParserErrorCodeMissingRequiredKey, ([NSString stringWithFormat:@"GtUrlParameterParser missing data for key: %@", key]));
		}
	}
	for(NSString* key in values)
	{
		if(![self _setDataInObject:object key:key data:[values objectForKey:key] strict:strict])
		{
			gotItAll = NO;
		}
	}
	
	return gotItAll;
}

+ (BOOL) parseData:(NSData*) data intoObject:(id) object strict:(BOOL) strict  requiredKeys:(NSArray*) requiredKeys;
{
	return [GtUrlParameterParser parseString:GtReturnAutoreleased([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]) intoObject:object strict:strict requiredKeys:requiredKeys];
}



@end
