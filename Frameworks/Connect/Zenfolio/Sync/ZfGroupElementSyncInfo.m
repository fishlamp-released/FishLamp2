//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGroupElementSyncInfo.m
//	Project: myZenfolio
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFGroupElementSyncInfo.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFGroupElementSyncInfo


@synthesize isGroup = _isGroup;
@synthesize name = _name;
@synthesize syncObjectId = _syncObjectId;

+ (NSString*) isGroupKey
{
	return @"isGroup";
}

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) syncObjectIdKey
{
	return @"syncObjectId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFGroupElementSyncInfo*)object).isGroup = FLCopyOrRetainObject(_isGroup);
	((ZFGroupElementSyncInfo*)object).syncObjectId = FLCopyOrRetainObject(_syncObjectId);
	((ZFGroupElementSyncInfo*)object).name = FLCopyOrRetainObject(_name);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_isGroup);
	FLRelease(_syncObjectId);
	FLRelease(_name);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_isGroup) [aCoder encodeObject:_isGroup forKey:@"_isGroup"];
	if(_syncObjectId) [aCoder encodeObject:_syncObjectId forKey:@"_syncObjectId"];
	if(_name) [aCoder encodeObject:_name forKey:@"_name"];
}

+ (ZFGroupElementSyncInfo*) groupElementSyncInfo
{
	return FLAutorelease([[ZFGroupElementSyncInfo alloc] init]);
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
		_isGroup = FLRetain([aDecoder decodeObjectForKey:@"_isGroup"]);
		_syncObjectId = FLRetain([aDecoder decodeObjectForKey:@"_syncObjectId"]);
		_name = FLRetain([aDecoder decodeObjectForKey:@"_name"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"isGroup" withClass:[FLBoolNumber class]];
		[describer setChildForIdentifier:@"syncObjectId" withClass:[FLIntegerNumber class]];
		[describer setChildForIdentifier:@"name" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}



- (BOOL) isModelObject {
    return YES;
}
+ (BOOL) isModelObject {
    return YES;
}
+ (FLDatabaseTable*) sharedDatabaseTable

{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"isGroup" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"syncObjectId" columnType:FLDatabaseTypeInteger columnConstraints:[NSArray arrayWithObject:[FLPrimaryKeyConstraint primaryKeyConstraint]]]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"name" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFGroupElementSyncInfo (ValueProperties) 

- (BOOL) isGroupValue
{
	return [self.isGroup boolValue];
}

- (void) setIsGroupValue:(BOOL) value
{
	self.isGroup = [NSNumber numberWithBool:value];
}

- (NSInteger) syncObjectIdValue
{
	return [self.syncObjectId integerValue];
}

- (void) setSyncObjectIdValue:(NSInteger) value
{
	self.syncObjectId = [NSNumber numberWithInteger:value];
}
@end

