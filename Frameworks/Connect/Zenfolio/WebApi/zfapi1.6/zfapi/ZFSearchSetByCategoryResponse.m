//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSearchSetByCategoryResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFSearchSetByCategoryResponse.h"
#import "ZFPhotoSetResult.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFSearchSetByCategoryResponse


@synthesize SearchSetByCategoryResult = _SearchSetByCategoryResult;

+ (NSString*) SearchSetByCategoryResultKey
{
	return @"SearchSetByCategoryResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFSearchSetByCategoryResponse*)object).SearchSetByCategoryResult = FLCopyOrRetainObject(_SearchSetByCategoryResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_SearchSetByCategoryResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_SearchSetByCategoryResult) [aCoder encodeObject:_SearchSetByCategoryResult forKey:@"_SearchSetByCategoryResult"];
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
		_SearchSetByCategoryResult = FLRetain([aDecoder decodeObjectForKey:@"_SearchSetByCategoryResult"]);
	}
	return self;
}

+ (ZFSearchSetByCategoryResponse*) searchSetByCategoryResponse
{
	return FLAutorelease([[ZFSearchSetByCategoryResponse alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"SearchSetByCategoryResult" withClass:[ZFPhotoSetResult class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"SearchSetByCategoryResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFSearchSetByCategoryResponse (ValueProperties) 
@end

