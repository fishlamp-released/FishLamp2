//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreatePhotoSetResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFCreatePhotoSetResponse.h"
#import "ZFPhotoSet.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFCreatePhotoSetResponse


@synthesize CreatePhotoSetResult = _CreatePhotoSetResult;

+ (NSString*) CreatePhotoSetResultKey
{
	return @"CreatePhotoSetResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFCreatePhotoSetResponse*)object).CreatePhotoSetResult = FLCopyOrRetainObject(_CreatePhotoSetResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (ZFCreatePhotoSetResponse*) createPhotoSetResponse
{
	return FLAutorelease([[ZFCreatePhotoSetResponse alloc] init]);
}

- (void) dealloc
{
	FLRelease(_CreatePhotoSetResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_CreatePhotoSetResult) [aCoder encodeObject:_CreatePhotoSetResult forKey:@"_CreatePhotoSetResult"];
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
		_CreatePhotoSetResult = FLRetain([aDecoder decodeObjectForKey:@"_CreatePhotoSetResult"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"CreatePhotoSetResult" withClass:[ZFPhotoSet class]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CreatePhotoSetResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFCreatePhotoSetResponse (ValueProperties) 
@end

