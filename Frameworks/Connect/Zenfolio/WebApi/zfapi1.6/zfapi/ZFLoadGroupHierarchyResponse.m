//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadGroupHierarchyResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadGroupHierarchyResponse.h"
#import "ZFGroup.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadGroupHierarchyResponse


@synthesize LoadGroupHierarchyResult = _LoadGroupHierarchyResult;

+ (NSString*) LoadGroupHierarchyResultKey
{
	return @"LoadGroupHierarchyResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFLoadGroupHierarchyResponse*)object).LoadGroupHierarchyResult = FLCopyOrRetainObject(_LoadGroupHierarchyResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_LoadGroupHierarchyResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_LoadGroupHierarchyResult) [aCoder encodeObject:_LoadGroupHierarchyResult forKey:@"_LoadGroupHierarchyResult"];
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
		_LoadGroupHierarchyResult = FLRetain([aDecoder decodeObjectForKey:@"_LoadGroupHierarchyResult"]);
	}
	return self;
}

+ (ZFLoadGroupHierarchyResponse*) loadGroupHierarchyResponse
{
	return FLAutorelease([[ZFLoadGroupHierarchyResponse alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"LoadGroupHierarchyResult" withClass:[ZFGroup class]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"LoadGroupHierarchyResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadGroupHierarchyResponse (ValueProperties) 
@end

