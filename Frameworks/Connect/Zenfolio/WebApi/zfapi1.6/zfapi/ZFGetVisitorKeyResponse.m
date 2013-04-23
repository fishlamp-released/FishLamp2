//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetVisitorKeyResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFGetVisitorKeyResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFGetVisitorKeyResponse


@synthesize GetVisitorKeyResult = _GetVisitorKeyResult;

+ (NSString*) GetVisitorKeyResultKey
{
	return @"GetVisitorKeyResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFGetVisitorKeyResponse*)object).GetVisitorKeyResult = FLCopyOrRetainObject(_GetVisitorKeyResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_GetVisitorKeyResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_GetVisitorKeyResult) [aCoder encodeObject:_GetVisitorKeyResult forKey:@"_GetVisitorKeyResult"];
}

+ (ZFGetVisitorKeyResponse*) getVisitorKeyResponse
{
	return FLAutorelease([[ZFGetVisitorKeyResponse alloc] init]);
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
		_GetVisitorKeyResult = FLRetain([aDecoder decodeObjectForKey:@"_GetVisitorKeyResult"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"GetVisitorKeyResult" withClass:[NSString class]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"GetVisitorKeyResult" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFGetVisitorKeyResponse (ValueProperties) 
@end

