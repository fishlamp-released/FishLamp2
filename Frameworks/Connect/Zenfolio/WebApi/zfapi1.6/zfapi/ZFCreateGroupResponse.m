//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreateGroupResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFCreateGroupResponse.h"
#import "ZFGroup.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFCreateGroupResponse


@synthesize CreateGroupResult = _CreateGroupResult;

+ (NSString*) CreateGroupResultKey
{
	return @"CreateGroupResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFCreateGroupResponse*)object).CreateGroupResult = FLCopyOrRetainObject(_CreateGroupResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (ZFCreateGroupResponse*) createGroupResponse
{
	return FLAutorelease([[ZFCreateGroupResponse alloc] init]);
}

- (void) dealloc
{
	FLRelease(_CreateGroupResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_CreateGroupResult) [aCoder encodeObject:_CreateGroupResult forKey:@"_CreateGroupResult"];
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
		_CreateGroupResult = FLRetain([aDecoder decodeObjectForKey:@"_CreateGroupResult"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"CreateGroupResult" withClass:[ZFGroup class]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CreateGroupResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFCreateGroupResponse (ValueProperties) 
@end

