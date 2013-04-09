//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAuthenticatePlainResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFAuthenticatePlainResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFAuthenticatePlainResponse


@synthesize AuthenticatePlainResult = _AuthenticatePlainResult;

+ (NSString*) AuthenticatePlainResultKey
{
	return @"AuthenticatePlainResult";
}

+ (ZFAuthenticatePlainResponse*) authenticatePlainResponse
{
	return FLAutorelease([[ZFAuthenticatePlainResponse alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFAuthenticatePlainResponse*)object).AuthenticatePlainResult = FLCopyOrRetainObject(_AuthenticatePlainResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_AuthenticatePlainResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_AuthenticatePlainResult) [aCoder encodeObject:_AuthenticatePlainResult forKey:@"_AuthenticatePlainResult"];
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
		_AuthenticatePlainResult = FLRetain([aDecoder decodeObjectForKey:@"_AuthenticatePlainResult"]);
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
		[s_describer addChildDescriberWithName:@"AuthenticatePlainResult" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"AuthenticatePlainResult" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFAuthenticatePlainResponse (ValueProperties) 
@end
