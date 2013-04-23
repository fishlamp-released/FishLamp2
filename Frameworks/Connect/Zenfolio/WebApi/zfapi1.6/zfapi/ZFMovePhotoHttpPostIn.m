//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFMovePhotoHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFMovePhotoHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFMovePhotoHttpPostIn


@synthesize destSetId = _destSetId;
@synthesize index = _index;
@synthesize photoId = _photoId;
@synthesize srcSetId = _srcSetId;

+ (NSString*) destSetIdKey
{
	return @"destSetId";
}

+ (NSString*) indexKey
{
	return @"index";
}

+ (NSString*) photoIdKey
{
	return @"photoId";
}

+ (NSString*) srcSetIdKey
{
	return @"srcSetId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFMovePhotoHttpPostIn*)object).destSetId = FLCopyOrRetainObject(_destSetId);
	((ZFMovePhotoHttpPostIn*)object).index = FLCopyOrRetainObject(_index);
	((ZFMovePhotoHttpPostIn*)object).photoId = FLCopyOrRetainObject(_photoId);
	((ZFMovePhotoHttpPostIn*)object).srcSetId = FLCopyOrRetainObject(_srcSetId);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_srcSetId);
	FLRelease(_photoId);
	FLRelease(_destSetId);
	FLRelease(_index);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_srcSetId) [aCoder encodeObject:_srcSetId forKey:@"_srcSetId"];
	if(_photoId) [aCoder encodeObject:_photoId forKey:@"_photoId"];
	if(_destSetId) [aCoder encodeObject:_destSetId forKey:@"_destSetId"];
	if(_index) [aCoder encodeObject:_index forKey:@"_index"];
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
		_srcSetId = FLRetain([aDecoder decodeObjectForKey:@"_srcSetId"]);
		_photoId = FLRetain([aDecoder decodeObjectForKey:@"_photoId"]);
		_destSetId = FLRetain([aDecoder decodeObjectForKey:@"_destSetId"]);
		_index = FLRetain([aDecoder decodeObjectForKey:@"_index"]);
	}
	return self;
}

+ (ZFMovePhotoHttpPostIn*) movePhotoHttpPostIn
{
	return FLAutorelease([[ZFMovePhotoHttpPostIn alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"srcSetId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"photoId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"destSetId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"index" withClass:[NSString class]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"srcSetId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"destSetId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"index" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFMovePhotoHttpPostIn (ValueProperties) 
@end

