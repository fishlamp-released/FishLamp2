//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPrivateProfileResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadPrivateProfileResponse.h"
#import "ZFUser.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadPrivateProfileResponse


@synthesize LoadPrivateProfileResult = _LoadPrivateProfileResult;

+ (NSString*) LoadPrivateProfileResultKey
{
	return @"LoadPrivateProfileResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFLoadPrivateProfileResponse*)object).LoadPrivateProfileResult = FLCopyOrRetainObject(_LoadPrivateProfileResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_LoadPrivateProfileResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_LoadPrivateProfileResult) [aCoder encodeObject:_LoadPrivateProfileResult forKey:@"_LoadPrivateProfileResult"];
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
		_LoadPrivateProfileResult = FLRetain([aDecoder decodeObjectForKey:@"_LoadPrivateProfileResult"]);
	}
	return self;
}

+ (ZFLoadPrivateProfileResponse*) loadPrivateProfileResponse
{
	return FLAutorelease([[ZFLoadPrivateProfileResponse alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"LoadPrivateProfileResult" withClass:[ZFUser class]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"LoadPrivateProfileResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadPrivateProfileResponse (ValueProperties) 
@end

