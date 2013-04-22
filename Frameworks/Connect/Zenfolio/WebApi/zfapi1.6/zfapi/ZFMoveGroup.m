//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFMoveGroup.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFMoveGroup.h"
#import "FLObjectDescriber.h"

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

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"groupId" withClass:[FLIntegerNumber class] ];
		[describer setChildForIdentifier:@"destGroupId" withClass:[FLIntegerNumber class] ];
		[describer setChildForIdentifier:@"index" withClass:[FLIntegerNumber class] ];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

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

