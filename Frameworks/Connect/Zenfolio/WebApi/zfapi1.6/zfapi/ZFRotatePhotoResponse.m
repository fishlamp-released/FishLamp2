//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFRotatePhotoResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFRotatePhotoResponse.h"
#import "ZFPhoto.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFRotatePhotoResponse


@synthesize RotatePhotoResult = _RotatePhotoResult;

+ (NSString*) RotatePhotoResultKey
{
	return @"RotatePhotoResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFRotatePhotoResponse*)object).RotatePhotoResult = FLCopyOrRetainObject(_RotatePhotoResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_RotatePhotoResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_RotatePhotoResult) [aCoder encodeObject:_RotatePhotoResult forKey:@"_RotatePhotoResult"];
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
		_RotatePhotoResult = FLRetain([aDecoder decodeObjectForKey:@"_RotatePhotoResult"]);
	}
	return self;
}

+ (ZFRotatePhotoResponse*) rotatePhotoResponse
{
	return FLAutorelease([[ZFRotatePhotoResponse alloc] init]);
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
		[s_describer setChildForIdentifier:@"RotatePhotoResult" withClass:[ZFPhoto class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"RotatePhotoResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFRotatePhotoResponse (ValueProperties) 
@end

