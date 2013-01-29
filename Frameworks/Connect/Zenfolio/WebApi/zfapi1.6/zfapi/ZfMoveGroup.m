//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFMoveGroup.m
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFMoveGroup.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation ZFMoveGroup


@synthesize destGroupId = _destGroupId;
@synthesize groupId = _groupId;
@synthesize index = _index;

+ (NSString*) destGroupIdKey
{
	return @"destGroupId";
}

+ (NSString*) groupIdKey
{
	return @"groupId";
}

+ (NSString*) indexKey
{
	return @"index";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFMoveGroup*)object).groupId = FLCopyOrRetainObject(_groupId);
	((ZFMoveGroup*)object).destGroupId = FLCopyOrRetainObject(_destGroupId);
	((ZFMoveGroup*)object).index = FLCopyOrRetainObject(_index);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_groupId);
	FLRelease(_destGroupId);
	FLRelease(_index);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_groupId) [aCoder encodeObject:_groupId forKey:@"_groupId"];
	if(_destGroupId) [aCoder encodeObject:_destGroupId forKey:@"_destGroupId"];
	if(_index) [aCoder encodeObject:_index forKey:@"_index"];
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
		_destGroupId = FLRetain([aDecoder decodeObjectForKey:@"_destGroupId"]);
		_index = FLRetain([aDecoder decodeObjectForKey:@"_index"]);
	}
	return self;
}

+ (ZFMoveGroup*) moveGroup
{
	return FLAutorelease([[ZFMoveGroup alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"destGroupId" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"destGroupId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"index" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"index"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"destGroupId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"index" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFMoveGroup (ValueProperties) 

- (int) groupIdValue
{
	return [self.groupId intValue];
}

- (void) setGroupIdValue:(int) value
{
	self.groupId = [NSNumber numberWithInt:value];
}

- (int) destGroupIdValue
{
	return [self.destGroupId intValue];
}

- (void) setDestGroupIdValue:(int) value
{
	self.destGroupId = [NSNumber numberWithInt:value];
}

- (int) indexValue
{
	return [self.index intValue];
}

- (void) setIndexValue:(int) value
{
	self.index = [NSNumber numberWithInt:value];
}
@end

