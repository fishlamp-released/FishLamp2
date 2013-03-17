//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCreateGroup.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioCreateGroup.h"
#import "FLZenfolioGroupUpdater.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioCreateGroup


@synthesize parentId = _parentId;
@synthesize updater = _updater;

+ (NSString*) parentIdKey
{
	return @"parentId";
}

+ (NSString*) updaterKey
{
	return @"updater";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioCreateGroup*)object).updater = FLCopyOrRetainObject(_updater);
	((FLZenfolioCreateGroup*)object).parentId = FLCopyOrRetainObject(_parentId);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (FLZenfolioCreateGroup*) createGroup
{
	return FLAutorelease([[FLZenfolioCreateGroup alloc] init]);
}

- (void) dealloc
{
	FLRelease(_parentId);
	FLRelease(_updater);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_parentId) [aCoder encodeObject:_parentId forKey:@"_parentId"];
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
		_parentId = FLRetain([aDecoder decodeObjectForKey:@"_parentId"]);
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
		[s_describer addProperty:@"parentId" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"updater" withClass:[FLZenfolioGroupUpdater class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"parentId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"updater" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioCreateGroup (ValueProperties) 

- (int) parentIdValue
{
	return [self.parentId intValue];
}

- (void) setParentIdValue:(int) value
{
	self.parentId = [NSNumber numberWithInt:value];
}
@end

