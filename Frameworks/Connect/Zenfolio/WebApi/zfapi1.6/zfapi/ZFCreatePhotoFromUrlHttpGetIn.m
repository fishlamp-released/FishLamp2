//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreatePhotoFromUrlHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFCreatePhotoFromUrlHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFCreatePhotoFromUrlHttpGetIn


@synthesize cookies = _cookies;
@synthesize galleryId = _galleryId;
@synthesize url = _url;

+ (NSString*) cookiesKey
{
	return @"cookies";
}

+ (NSString*) galleryIdKey
{
	return @"galleryId";
}

+ (NSString*) urlKey
{
	return @"url";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFCreatePhotoFromUrlHttpGetIn*)object).url = FLCopyOrRetainObject(_url);
	((ZFCreatePhotoFromUrlHttpGetIn*)object).galleryId = FLCopyOrRetainObject(_galleryId);
	((ZFCreatePhotoFromUrlHttpGetIn*)object).cookies = FLCopyOrRetainObject(_cookies);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (ZFCreatePhotoFromUrlHttpGetIn*) createPhotoFromUrlHttpGetIn
{
	return FLAutorelease([[ZFCreatePhotoFromUrlHttpGetIn alloc] init]);
}

- (void) dealloc
{
	FLRelease(_galleryId);
	FLRelease(_url);
	FLRelease(_cookies);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_galleryId) [aCoder encodeObject:_galleryId forKey:@"_galleryId"];
	if(_url) [aCoder encodeObject:_url forKey:@"_url"];
	if(_cookies) [aCoder encodeObject:_cookies forKey:@"_cookies"];
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
		_galleryId = FLRetain([aDecoder decodeObjectForKey:@"_galleryId"]);
		_url = FLRetain([aDecoder decodeObjectForKey:@"_url"]);
		_cookies = FLRetain([aDecoder decodeObjectForKey:@"_cookies"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
		}
		[s_describer addChildDescriberWithName:@"galleryId" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"url" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"cookies" withClass:[NSString class]];
	});
	return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
	static FLObjectInflator* s_inflator = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] objectDescriber]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"galleryId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"url" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"cookies" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFCreatePhotoFromUrlHttpGetIn (ValueProperties) 
@end
