//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPhotoHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadPhotoHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadPhotoHttpPostIn


@synthesize level = _level;
@synthesize photoId = _photoId;

+ (NSString*) levelKey
{
	return @"level";
}

+ (NSString*) photoIdKey
{
	return @"photoId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFLoadPhotoHttpPostIn*)object).photoId = FLCopyOrRetainObject(_photoId);
	((ZFLoadPhotoHttpPostIn*)object).level = FLCopyOrRetainObject(_level);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_photoId);
	FLRelease(_level);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoId) [aCoder encodeObject:_photoId forKey:@"_photoId"];
	if(_level) [aCoder encodeObject:_level forKey:@"_level"];
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
		_photoId = FLRetain([aDecoder decodeObjectForKey:@"_photoId"]);
		_level = FLRetain([aDecoder decodeObjectForKey:@"_level"]);
	}
	return self;
}

+ (ZFLoadPhotoHttpPostIn*) loadPhotoHttpPostIn
{
	return FLAutorelease([[ZFLoadPhotoHttpPostIn alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"photoId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"level" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"level" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadPhotoHttpPostIn (ValueProperties) 
@end

