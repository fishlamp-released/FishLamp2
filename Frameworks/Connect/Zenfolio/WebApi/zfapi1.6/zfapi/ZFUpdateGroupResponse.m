//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdateGroupResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFUpdateGroupResponse.h"
#import "ZFGroup.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFUpdateGroupResponse


@synthesize UpdateGroupResult = _UpdateGroupResult;

+ (NSString*) UpdateGroupResultKey
{
	return @"UpdateGroupResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFUpdateGroupResponse*)object).UpdateGroupResult = FLCopyOrRetainObject(_UpdateGroupResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_UpdateGroupResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_UpdateGroupResult) [aCoder encodeObject:_UpdateGroupResult forKey:@"_UpdateGroupResult"];
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
		_UpdateGroupResult = FLRetain([aDecoder decodeObjectForKey:@"_UpdateGroupResult"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"UpdateGroupResult" withClass:[ZFGroup class]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"UpdateGroupResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

+ (ZFUpdateGroupResponse*) updateGroupResponse
{
	return FLAutorelease([[ZFUpdateGroupResponse alloc] init]);
}

@end

@implementation ZFUpdateGroupResponse (ValueProperties) 
@end

