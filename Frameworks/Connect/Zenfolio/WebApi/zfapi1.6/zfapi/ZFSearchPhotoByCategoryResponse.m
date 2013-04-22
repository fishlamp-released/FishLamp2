//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSearchPhotoByCategoryResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFSearchPhotoByCategoryResponse.h"
#import "ZFPhotoResult.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFSearchPhotoByCategoryResponse


@synthesize SearchPhotoByCategoryResult = _SearchPhotoByCategoryResult;

+ (NSString*) SearchPhotoByCategoryResultKey
{
	return @"SearchPhotoByCategoryResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFSearchPhotoByCategoryResponse*)object).SearchPhotoByCategoryResult = FLCopyOrRetainObject(_SearchPhotoByCategoryResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_SearchPhotoByCategoryResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_SearchPhotoByCategoryResult) [aCoder encodeObject:_SearchPhotoByCategoryResult forKey:@"_SearchPhotoByCategoryResult"];
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
		_SearchPhotoByCategoryResult = FLRetain([aDecoder decodeObjectForKey:@"_SearchPhotoByCategoryResult"]);
	}
	return self;
}

+ (ZFSearchPhotoByCategoryResponse*) searchPhotoByCategoryResponse
{
	return FLAutorelease([[ZFSearchPhotoByCategoryResponse alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"SearchPhotoByCategoryResult" withClass:[ZFPhotoResult class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"SearchPhotoByCategoryResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFSearchPhotoByCategoryResponse (ValueProperties) 
@end

