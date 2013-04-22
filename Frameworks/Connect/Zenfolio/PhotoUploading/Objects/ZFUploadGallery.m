//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUploadGallery.m
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFUploadGallery.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFUploadGallery


@synthesize name = _name;
@synthesize photoSetId = _photoSetId;
@synthesize uploadUrl = _uploadUrl;

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) photoSetIdKey
{
	return @"photoSetId";
}

+ (NSString*) uploadUrlKey
{
	return @"uploadUrl";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFUploadGallery*)object).name = FLCopyOrRetainObject(_name);
	((ZFUploadGallery*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
	((ZFUploadGallery*)object).uploadUrl = FLCopyOrRetainObject(_uploadUrl);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_name);
	FLRelease(_photoSetId);
	FLRelease(_uploadUrl);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_name) [aCoder encodeObject:_name forKey:@"_name"];
	if(_photoSetId) [aCoder encodeObject:_photoSetId forKey:@"_photoSetId"];
	if(_uploadUrl) [aCoder encodeObject:_uploadUrl forKey:@"_uploadUrl"];
	[super encodeWithCoder:aCoder];
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
	if((self = [super initWithCoder:aDecoder]))
	{
		_name = FLRetain([aDecoder decodeObjectForKey:@"_name"]);
		_photoSetId = FLRetain([aDecoder decodeObjectForKey:@"_photoSetId"]);
		_uploadUrl = FLRetain([aDecoder decodeObjectForKey:@"_uploadUrl"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"name" withClass:[NSString class]];
		[describer setChildForIdentifier:@"photoSetId" withClass:[FLIntegerNumber class] ];
		[describer setChildForIdentifier:@"uploadUrl" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"name" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoSetId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadUrl" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

+ (ZFUploadGallery*) uploadGallery
{
	return FLAutorelease([[ZFUploadGallery alloc] init]);
}

@end

@implementation ZFUploadGallery (ValueProperties) 

- (int) photoSetIdValue
{
	return [self.photoSetId intValue];
}

- (void) setPhotoSetIdValue:(int) value
{
	self.photoSetId = [NSNumber numberWithInt:value];
}
@end

