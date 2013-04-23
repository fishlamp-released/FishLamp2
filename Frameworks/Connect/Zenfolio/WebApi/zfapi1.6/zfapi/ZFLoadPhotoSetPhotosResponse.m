//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPhotoSetPhotosResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadPhotoSetPhotosResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "ZFPhoto.h"

@implementation ZFLoadPhotoSetPhotosResponse


@synthesize LoadPhotoSetPhotosResult = _LoadPhotoSetPhotosResult;

+ (NSString*) LoadPhotoSetPhotosResultKey
{
	return @"LoadPhotoSetPhotosResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFLoadPhotoSetPhotosResponse*)object).LoadPhotoSetPhotosResult = FLCopyOrRetainObject(_LoadPhotoSetPhotosResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_LoadPhotoSetPhotosResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_LoadPhotoSetPhotosResult) [aCoder encodeObject:_LoadPhotoSetPhotosResult forKey:@"_LoadPhotoSetPhotosResult"];
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
		_LoadPhotoSetPhotosResult = [[aDecoder decodeObjectForKey:@"_LoadPhotoSetPhotosResult"] mutableCopy];
	}
	return self;
}

+ (ZFLoadPhotoSetPhotosResponse*) loadPhotoSetPhotosResponse
{
	return FLAutorelease([[ZFLoadPhotoSetPhotosResponse alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"LoadPhotoSetPhotosResult" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"Photo" class:[ZFPhoto class]], nil]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"LoadPhotoSetPhotosResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadPhotoSetPhotosResponse (ValueProperties) 
@end

