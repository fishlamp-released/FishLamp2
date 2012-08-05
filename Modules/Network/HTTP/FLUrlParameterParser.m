//
//  FLUrlParameterParser.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/3/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLUrlParameterParser.h"
#import "NSString+URL.h"

@implementation FLUrlParameterParser

+ (BOOL) _setDataInObject:(id) object key:(NSString*) key data:(id) data strict:(BOOL)strict
{
//	FLObjectDescriber* describer = [[object class] sharedObjectDescriber];
//	FLAssertIsNotNil(describer);
//
//	FLPropertyDescription* desc = [describer propertyDescriberForPropertyName:key];
//	FLAssertIsNotNil(desc);

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
		FLThrowErrorCode(FLUrlParamenterParserErrorDomain, FLUrlParameterParserErrorCodeUnexpectedData, ([NSString stringWithFormat:@"FLUrlParameterParser got unexpected data for key: %@", key]));
	}
	else
	{
		FLDebugLog(@"FLUrlParameterParser skipped data (not in dest object): %@=%@", key, data);
	}
	
	return NO;
}

+ (BOOL) parseString:(NSString*) string intoObject:(id) object  strict:(BOOL) strict
{
	BOOL gotItAll = YES;
	NSDictionary* values = [NSString parseURLParams:string];
	for(NSString* key in values)
	{
		if(![FLUrlParameterParser _setDataInObject:object key:key data:[values objectForKey:key] strict:strict])
		{
			gotItAll = NO;
		}
	}
	
	return gotItAll;
}

+ (BOOL) parseData:(NSData*) data intoObject:(id) object strict:(BOOL) strict
{
	return [FLUrlParameterParser parseString:FLReturnAutoreleased([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]) intoObject:object strict:strict];
}

+ (BOOL) parseString:(NSString*) string intoObject:(id) object strict:(BOOL) strict requiredKeys:(NSArray*) requiredKeys
{
	BOOL gotItAll = YES;
	NSMutableDictionary* values = FLReturnAutoreleased([[NSString parseURLParams:string] mutableCopy]);
	
	for(NSString* key in requiredKeys)
	{
		id data = [values objectForKey:key];
		if(data)
		{
			if(![FLUrlParameterParser _setDataInObject:object key:key data:data strict:strict])
			{
				gotItAll = NO;
			}
			[values removeObjectForKey:key];	
		}
		else
		{
			FLThrowErrorCode(FLUrlParamenterParserErrorDomain, FLUrlParameterParserErrorCodeMissingRequiredKey, ([NSString stringWithFormat:@"FLUrlParameterParser missing data for key: %@", key]));
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
	return [FLUrlParameterParser parseString:FLReturnAutoreleased([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]) intoObject:object strict:strict requiredKeys:requiredKeys];
}



@end
