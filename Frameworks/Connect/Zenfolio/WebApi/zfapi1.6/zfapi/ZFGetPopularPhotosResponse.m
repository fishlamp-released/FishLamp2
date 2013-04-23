//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetPopularPhotosResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFGetPopularPhotosResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "ZFPhoto.h"

@implementation ZFGetPopularPhotosResponse


@synthesize GetPopularPhotosResult = _GetPopularPhotosResult;

+ (NSString*) GetPopularPhotosResultKey
{
	return @"GetPopularPhotosResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFGetPopularPhotosResponse*)object).GetPopularPhotosResult = FLCopyOrRetainObject(_GetPopularPhotosResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_GetPopularPhotosResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_GetPopularPhotosResult) [aCoder encodeObject:_GetPopularPhotosResult forKey:@"_GetPopularPhotosResult"];
}

+ (ZFGetPopularPhotosResponse*) getPopularPhotosResponse
{
	return FLAutorelease([[ZFGetPopularPhotosResponse alloc] init]);
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
		_GetPopularPhotosResult = [[aDecoder decodeObjectForKey:@"_GetPopularPhotosResult"] mutableCopy];
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"GetPopularPhotosResult" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"Photo" class:[ZFPhoto class]], nil]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"GetPopularPhotosResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFGetPopularPhotosResponse (ValueProperties) 
@end

