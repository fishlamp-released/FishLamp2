//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdatePhotoResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFUpdatePhotoResponse.h"
#import "ZFPhoto.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFUpdatePhotoResponse


@synthesize UpdatePhotoResult = _UpdatePhotoResult;

+ (NSString*) UpdatePhotoResultKey
{
	return @"UpdatePhotoResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFUpdatePhotoResponse*)object).UpdatePhotoResult = FLCopyOrRetainObject(_UpdatePhotoResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_UpdatePhotoResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_UpdatePhotoResult) [aCoder encodeObject:_UpdatePhotoResult forKey:@"_UpdatePhotoResult"];
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
		_UpdatePhotoResult = FLRetain([aDecoder decodeObjectForKey:@"_UpdatePhotoResult"]);
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
		[s_describer setChildForIdentifier:@"UpdatePhotoResult" withClass:[ZFPhoto class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"UpdatePhotoResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

+ (ZFUpdatePhotoResponse*) updatePhotoResponse
{
	return FLAutorelease([[ZFUpdatePhotoResponse alloc] init]);
}

@end

@implementation ZFUpdatePhotoResponse (ValueProperties) 
@end

