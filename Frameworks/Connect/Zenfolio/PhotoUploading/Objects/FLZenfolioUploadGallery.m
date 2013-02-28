//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUploadGallery.m
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioUploadGallery.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZenfolioUploadGallery


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
	((FLZenfolioUploadGallery*)object).name = FLCopyOrRetainObject(_name);
	((FLZenfolioUploadGallery*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
	((FLZenfolioUploadGallery*)object).uploadUrl = FLCopyOrRetainObject(_uploadUrl);
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

+ (FLObjectDescriber*) sharedObjectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_describer = [[super sharedObjectDescriber] copy];
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] init];
		}
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"name" propertyClass:[NSString class] ] ];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"photoSetId" propertyClass:[FLIntegerNumber class]] ];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadUrl" propertyClass:[NSString class] ] ];
	});
	return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
	static FLObjectInflator* s_inflator = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] sharedObjectDescriber]];
	});
	return s_inflator;
}

+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		FLDatabaseTable* superTable = [super sharedDatabaseTable];
		if(superTable)
		{
			s_table = [superTable copy];
			s_table.tableName = [self databaseTableName];
		}
		else
		{
			s_table = [[FLDatabaseTable alloc] initWithTableName:[self databaseTableName]];
		}
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"name" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoSetId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadUrl" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

+ (FLZenfolioUploadGallery*) uploadGallery
{
	return FLAutorelease([[FLZenfolioUploadGallery alloc] init]);
}

@end

@implementation FLZenfolioUploadGallery (ValueProperties) 

- (int) photoSetIdValue
{
	return [self.photoSetId intValue];
}

- (void) setPhotoSetIdValue:(int) value
{
	self.photoSetId = [NSNumber numberWithInt:value];
}
@end
