//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetRecentPhotosResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFGetRecentPhotosResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "ZFPhoto.h"

@implementation ZFGetRecentPhotosResponse


@synthesize GetRecentPhotosResult = _GetRecentPhotosResult;

+ (NSString*) GetRecentPhotosResultKey
{
	return @"GetRecentPhotosResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFGetRecentPhotosResponse*)object).GetRecentPhotosResult = FLCopyOrRetainObject(_GetRecentPhotosResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_GetRecentPhotosResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_GetRecentPhotosResult) [aCoder encodeObject:_GetRecentPhotosResult forKey:@"_GetRecentPhotosResult"];
}

+ (ZFGetRecentPhotosResponse*) getRecentPhotosResponse
{
	return FLAutorelease([[ZFGetRecentPhotosResponse alloc] init]);
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
		_GetRecentPhotosResult = [[aDecoder decodeObjectForKey:@"_GetRecentPhotosResult"] mutableCopy];
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"GetRecentPhotosResult" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"Photo" class:[ZFPhoto class]], nil]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"GetRecentPhotosResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFGetRecentPhotosResponse (ValueProperties) 
@end

