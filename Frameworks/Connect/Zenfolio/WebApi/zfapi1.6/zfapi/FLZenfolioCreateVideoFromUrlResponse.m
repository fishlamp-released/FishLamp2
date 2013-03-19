//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCreateVideoFromUrlResponse.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioCreateVideoFromUrlResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioCreateVideoFromUrlResponse


@synthesize CreateVideoFromUrlResult = _CreateVideoFromUrlResult;

+ (NSString*) CreateVideoFromUrlResultKey
{
	return @"CreateVideoFromUrlResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioCreateVideoFromUrlResponse*)object).CreateVideoFromUrlResult = FLCopyOrRetainObject(_CreateVideoFromUrlResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (FLZenfolioCreateVideoFromUrlResponse*) createVideoFromUrlResponse
{
	return FLAutorelease([[FLZenfolioCreateVideoFromUrlResponse alloc] init]);
}

- (void) dealloc
{
	FLRelease(_CreateVideoFromUrlResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_CreateVideoFromUrlResult) [aCoder encodeObject:_CreateVideoFromUrlResult forKey:@"_CreateVideoFromUrlResult"];
}

- (id) init
{
	if((self = [super init]))
	{
	}
	return self;
}

- (id) initWithCoder:(NSCoder*) aDecoder
{
	if((self = [super init]))
	{
		_CreateVideoFromUrlResult = FLRetain([aDecoder decodeObjectForKey:@"_CreateVideoFromUrlResult"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
		}
		[s_describer addProperty:@"CreateVideoFromUrlResult" withClass:[FLIntegerNumber class] ];
	});
	return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
	static FLObjectInflator* s_inflator = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] objectDescriber]];
	});
	return s_inflator;
}

+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		FLDatabaseTable* superTable = [super sharedDatabaseTable];
		if(superTable)
		{
			s_table = [superTable copy];
			s_table.tableName = [self databaseTableName];
		}
		else
		{
			s_table = [[FLDatabaseTable alloc] initWithTableName:[self databaseTableName]];
		}
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CreateVideoFromUrlResult" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioCreateVideoFromUrlResponse (ValueProperties) 

- (int) CreateVideoFromUrlResultValue
{
	return [self.CreateVideoFromUrlResult intValue];
}

- (void) setCreateVideoFromUrlResultValue:(int) value
{
	self.CreateVideoFromUrlResult = [NSNumber numberWithInt:value];
}
@end

