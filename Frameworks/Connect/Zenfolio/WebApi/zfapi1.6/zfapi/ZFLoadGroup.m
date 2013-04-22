//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadGroup.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadGroup.h"
#import "ZFApi1_6Enums.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadGroup


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
	((ZFLoadGroup*)object).groupId = FLCopyOrRetainObject(_groupId);
	((ZFLoadGroup*)object).level = FLCopyOrRetainObject(_level);
	((ZFLoadGroup*)object).includeChildren = FLCopyOrRetainObject(_includeChildren);
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

+ (ZFLoadGroup*) loadGroup
{
	return FLAutorelease([[ZFLoadGroup alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"groupId" withClass:[FLIntegerNumber class] ];
		[describer setChildForIdentifier:@"level" withClass:[NSString class]];
		[describer setChildForIdentifier:@"includeChildren" withClass:[FLBoolNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"level" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"includeChildren" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadGroup (ValueProperties) 

- (int) groupIdValue
{
	return [self.groupId intValue];
}

- (void) setGroupIdValue:(int) value
{
	self.groupId = [NSNumber numberWithInt:value];
}

- (ZFInformatonLevel) levelValue
{
	return [[ZFApi1_6EnumLookup instance] informatonLevelFromString:self.level];
}

- (void) setLevelValue:(ZFInformatonLevel) inEnumValue
{
	self.level = [[ZFApi1_6EnumLookup instance] stringFromInformatonLevel:inEnumValue];
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

