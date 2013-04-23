//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdatePhotoSetResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFUpdatePhotoSetResponse.h"
#import "ZFPhotoSet.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFUpdatePhotoSetResponse


@synthesize UpdatePhotoSetResult = _UpdatePhotoSetResult;

+ (NSString*) UpdatePhotoSetResultKey
{
	return @"UpdatePhotoSetResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFUpdatePhotoSetResponse*)object).UpdatePhotoSetResult = FLCopyOrRetainObject(_UpdatePhotoSetResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_UpdatePhotoSetResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_UpdatePhotoSetResult) [aCoder encodeObject:_UpdatePhotoSetResult forKey:@"_UpdatePhotoSetResult"];
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
		_UpdatePhotoSetResult = FLRetain([aDecoder decodeObjectForKey:@"_UpdatePhotoSetResult"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"UpdatePhotoSetResult" withClass:[ZFPhotoSet class]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"UpdatePhotoSetResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

+ (ZFUpdatePhotoSetResponse*) updatePhotoSetResponse
{
	return FLAutorelease([[ZFUpdatePhotoSetResponse alloc] init]);
}

@end

@implementation ZFUpdatePhotoSetResponse (ValueProperties) 
@end

