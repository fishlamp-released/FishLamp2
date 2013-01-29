//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCreatePhotoSet.m
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfCreatePhotoSet.h"
#import "FLZfApi1_6Enums.h"
#import "FLZfPhotoSetUpdater.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfCreatePhotoSet


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
	((FLZfCreatePhotoSet*)object).groupId = FLCopyOrRetainObject(_groupId);
	((FLZfCreatePhotoSet*)object).type = FLCopyOrRetainObject(_type);
	((FLZfCreatePhotoSet*)object).updater = FLCopyOrRetainObject(_updater);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (FLZfCreatePhotoSet*) createPhotoSet
{
	return FLAutorelease([[FLZfCreatePhotoSet alloc] init]);
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

+ (FLObjectDescriber*) sharedObjectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_describer = [[super sharedObjectDescriber] copy];
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] init];
		}
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"groupId" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"groupId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"type" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"type"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"updater" propertyClass:[FLZfPhotoSetUpdater class] propertyType:FLDataTypeObject] forPropertyName:@"updater"];
	});
	return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
	static FLObjectInflator* s_inflator = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] sharedObjectDescriber]];
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

@implementation FLZfCreatePhotoSet (ValueProperties) 

- (int) groupIdValue
{
	return [self.groupId intValue];
}

- (void) setGroupIdValue:(int) value
{
	self.groupId = [NSNumber numberWithInt:value];
}

- (FLZfPhotoSetType) typeValue
{
	return [[FLZfApi1_6EnumLookup instance] photoSetTypeFromString:self.type];
}

- (void) setTypeValue:(FLZfPhotoSetType) inEnumValue
{
	self.type = [[FLZfApi1_6EnumLookup instance] stringFromPhotoSetType:inEnumValue];
}
@end

