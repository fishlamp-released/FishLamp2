//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCreatePhotoSet.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioCreatePhotoSet.h"
#import "FLZenfolioApi1_6Enums.h"
#import "FLZenfolioPhotoSetUpdater.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioCreatePhotoSet


@synthesize groupId = _groupId;
@synthesize type = _type;
@synthesize updater = _updater;

+ (NSString*) groupIdKey
{
	return @"groupId";
}

+ (NSString*) typeKey
{
	return @"type";
}

+ (NSString*) updaterKey
{
	return @"updater";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioCreatePhotoSet*)object).groupId = FLCopyOrRetainObject(_groupId);
	((FLZenfolioCreatePhotoSet*)object).type = FLCopyOrRetainObject(_type);
	((FLZenfolioCreatePhotoSet*)object).updater = FLCopyOrRetainObject(_updater);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (FLZenfolioCreatePhotoSet*) createPhotoSet
{
	return FLAutorelease([[FLZenfolioCreatePhotoSet alloc] init]);
}

- (void) dealloc
{
	FLRelease(_groupId);
	FLRelease(_type);
	FLRelease(_updater);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_groupId) [aCoder encodeObject:_groupId forKey:@"_groupId"];
	if(_type) [aCoder encodeObject:_type forKey:@"_type"];
	if(_updater) [aCoder encodeObject:_updater forKey:@"_updater"];
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
		_groupId = FLRetain([aDecoder decodeObjectForKey:@"_groupId"]);
		_type = FLRetain([aDecoder decodeObjectForKey:@"_type"]);
		_updater = FLRetain([aDecoder decodeObjectForKey:@"_updater"]);
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
		[s_describer addProperty:@"groupId" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"type" withClass:[NSString class]];
		[s_describer addProperty:@"updater" withClass:[FLZenfolioPhotoSetUpdater class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"groupId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"type" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"updater" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioCreatePhotoSet (ValueProperties) 

- (int) groupIdValue
{
	return [self.groupId intValue];
}

- (void) setGroupIdValue:(int) value
{
	self.groupId = [NSNumber numberWithInt:value];
}

- (FLZenfolioPhotoSetType) typeValue
{
	return [[FLZenfolioApi1_6EnumLookup instance] photoSetTypeFromString:self.type];
}

- (void) setTypeValue:(FLZenfolioPhotoSetType) inEnumValue
{
	self.type = [[FLZenfolioApi1_6EnumLookup instance] stringFromPhotoSetType:inEnumValue];
}
@end

