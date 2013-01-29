//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadGroup.m
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfLoadGroup.h"
#import "FLZfApi1_6Enums.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfLoadGroup


@synthesize groupId = _groupId;
@synthesize includeChildren = _includeChildren;
@synthesize level = _level;

+ (NSString*) groupIdKey
{
	return @"groupId";
}

+ (NSString*) includeChildrenKey
{
	return @"includeChildren";
}

+ (NSString*) levelKey
{
	return @"level";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfLoadGroup*)object).groupId = FLCopyOrRetainObject(_groupId);
	((FLZfLoadGroup*)object).level = FLCopyOrRetainObject(_level);
	((FLZfLoadGroup*)object).includeChildren = FLCopyOrRetainObject(_includeChildren);
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
	FLRelease(_level);
	FLRelease(_includeChildren);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_groupId) [aCoder encodeObject:_groupId forKey:@"_groupId"];
	if(_level) [aCoder encodeObject:_level forKey:@"_level"];
	if(_includeChildren) [aCoder encodeObject:_includeChildren forKey:@"_includeChildren"];
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
		_level = FLRetain([aDecoder decodeObjectForKey:@"_level"]);
		_includeChildren = FLRetain([aDecoder decodeObjectForKey:@"_includeChildren"]);
	}
	return self;
}

+ (FLZfLoadGroup*) loadGroup
{
	return FLAutorelease([[FLZfLoadGroup alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"level" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"level"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"includeChildren" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"includeChildren"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"level" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"includeChildren" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfLoadGroup (ValueProperties) 

- (int) groupIdValue
{
	return [self.groupId intValue];
}

- (void) setGroupIdValue:(int) value
{
	self.groupId = [NSNumber numberWithInt:value];
}

- (FLZfInformatonLevel) levelValue
{
	return [[FLZfApi1_6EnumLookup instance] informatonLevelFromString:self.level];
}

- (void) setLevelValue:(FLZfInformatonLevel) inEnumValue
{
	self.level = [[FLZfApi1_6EnumLookup instance] stringFromInformatonLevel:inEnumValue];
}

- (BOOL) includeChildrenValue
{
	return [self.includeChildren boolValue];
}

- (void) setIncludeChildrenValue:(BOOL) value
{
	self.includeChildren = [NSNumber numberWithBool:value];
}
@end

