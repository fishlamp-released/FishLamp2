//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPublicProfileResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadPublicProfileResponse.h"
#import "ZFUser.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadPublicProfileResponse


@synthesize LoadPublicProfileResult = _LoadPublicProfileResult;

+ (NSString*) LoadPublicProfileResultKey
{
	return @"LoadPublicProfileResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFLoadPublicProfileResponse*)object).LoadPublicProfileResult = FLCopyOrRetainObject(_LoadPublicProfileResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_LoadPublicProfileResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_LoadPublicProfileResult) [aCoder encodeObject:_LoadPublicProfileResult forKey:@"_LoadPublicProfileResult"];
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
		_LoadPublicProfileResult = FLRetain([aDecoder decodeObjectForKey:@"_LoadPublicProfileResult"]);
	}
	return self;
}

+ (ZFLoadPublicProfileResponse*) loadPublicProfileResponse
{
	return FLAutorelease([[ZFLoadPublicProfileResponse alloc] init]);
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
		[s_describer setChildForIdentifier:@"LoadPublicProfileResult" withClass:[ZFUser class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"LoadPublicProfileResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadPublicProfileResponse (ValueProperties) 
@end

