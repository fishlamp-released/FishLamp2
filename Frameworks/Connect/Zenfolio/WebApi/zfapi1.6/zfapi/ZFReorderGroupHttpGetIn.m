//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFReorderGroupHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFReorderGroupHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFReorderGroupHttpGetIn


@synthesize groupId = _groupId;
@synthesize shiftOrder = _shiftOrder;

+ (NSString*) groupIdKey
{
	return @"groupId";
}

+ (NSString*) shiftOrderKey
{
	return @"shiftOrder";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFReorderGroupHttpGetIn*)object).groupId = FLCopyOrRetainObject(_groupId);
	((ZFReorderGroupHttpGetIn*)object).shiftOrder = FLCopyOrRetainObject(_shiftOrder);
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
	FLRelease(_shiftOrder);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_groupId) [aCoder encodeObject:_groupId forKey:@"_groupId"];
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
		_groupId = FLRetain([aDecoder decodeObjectForKey:@"_groupId"]);
		_shiftOrder = FLRetain([aDecoder decodeObjectForKey:@"_shiftOrder"]);
	}
	return self;
}

+ (ZFReorderGroupHttpGetIn*) reorderGroupHttpGetIn
{
	return FLAutorelease([[ZFReorderGroupHttpGetIn alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"groupId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"shiftOrder" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"groupId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"shiftOrder" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFReorderGroupHttpGetIn (ValueProperties) 
@end

