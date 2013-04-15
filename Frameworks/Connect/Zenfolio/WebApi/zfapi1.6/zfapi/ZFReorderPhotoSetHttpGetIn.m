//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFReorderPhotoSetHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFReorderPhotoSetHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFReorderPhotoSetHttpGetIn


@synthesize photoSetId = _photoSetId;
@synthesize shiftOrder = _shiftOrder;

+ (NSString*) photoSetIdKey
{
	return @"photoSetId";
}

+ (NSString*) shiftOrderKey
{
	return @"shiftOrder";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFReorderPhotoSetHttpGetIn*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
	((ZFReorderPhotoSetHttpGetIn*)object).shiftOrder = FLCopyOrRetainObject(_shiftOrder);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_photoSetId);
	FLRelease(_shiftOrder);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoSetId) [aCoder encodeObject:_photoSetId forKey:@"_photoSetId"];
	if(_shiftOrder) [aCoder encodeObject:_shiftOrder forKey:@"_shiftOrder"];
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
		_photoSetId = FLRetain([aDecoder decodeObjectForKey:@"_photoSetId"]);
		_shiftOrder = FLRetain([aDecoder decodeObjectForKey:@"_shiftOrder"]);
	}
	return self;
}

+ (ZFReorderPhotoSetHttpGetIn*) reorderPhotoSetHttpGetIn
{
	return FLAutorelease([[ZFReorderPhotoSetHttpGetIn alloc] init]);
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
		[s_describer setChildForIdentifier:@"photoSetId" withClass:[NSString class]];
		[s_describer setChildForIdentifier:@"shiftOrder" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoSetId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"shiftOrder" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFReorderPhotoSetHttpGetIn (ValueProperties) 
@end

