//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFReindexPhotoSetHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFReindexPhotoSetHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFReindexPhotoSetHttpPostIn


@synthesize mapping = _mapping;
@synthesize photoSetId = _photoSetId;
@synthesize startIndex = _startIndex;

+ (NSString*) mappingKey
{
	return @"mapping";
}

+ (NSString*) photoSetIdKey
{
	return @"photoSetId";
}

+ (NSString*) startIndexKey
{
	return @"startIndex";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFReindexPhotoSetHttpPostIn*)object).startIndex = FLCopyOrRetainObject(_startIndex);
	((ZFReindexPhotoSetHttpPostIn*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
	((ZFReindexPhotoSetHttpPostIn*)object).mapping = FLCopyOrRetainObject(_mapping);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_photoSetId);
	FLRelease(_startIndex);
	FLRelease(_mapping);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoSetId) [aCoder encodeObject:_photoSetId forKey:@"_photoSetId"];
	if(_startIndex) [aCoder encodeObject:_startIndex forKey:@"_startIndex"];
	if(_mapping) [aCoder encodeObject:_mapping forKey:@"_mapping"];
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
		_photoSetId = FLRetain([aDecoder decodeObjectForKey:@"_photoSetId"]);
		_startIndex = FLRetain([aDecoder decodeObjectForKey:@"_startIndex"]);
		_mapping = [[aDecoder decodeObjectForKey:@"_mapping"] mutableCopy];
	}
	return self;
}

+ (ZFReindexPhotoSetHttpPostIn*) reindexPhotoSetHttpPostIn
{
	return FLAutorelease([[ZFReindexPhotoSetHttpPostIn alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"photoSetId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"startIndex" withClass:[NSString class]];
		[describer setChildForIdentifier:@"mapping" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"String" class:[NSString class] ], nil]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoSetId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"startIndex" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"mapping" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFReindexPhotoSetHttpPostIn (ValueProperties) 
@end

