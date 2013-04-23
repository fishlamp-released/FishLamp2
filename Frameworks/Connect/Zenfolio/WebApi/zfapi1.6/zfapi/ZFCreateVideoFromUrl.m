//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreateVideoFromUrl.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFCreateVideoFromUrl.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFCreateVideoFromUrl


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
	((ZFCreateVideoFromUrl*)object).url = FLCopyOrRetainObject(_url);
	((ZFCreateVideoFromUrl*)object).galleryId = FLCopyOrRetainObject(_galleryId);
	((ZFCreateVideoFromUrl*)object).cookies = FLCopyOrRetainObject(_cookies);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (ZFCreateVideoFromUrl*) createVideoFromUrl
{
	return FLAutorelease([[ZFCreateVideoFromUrl alloc] init]);
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
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"galleryId" withClass:[FLIntegerNumber class] ];
		[describer setChildForIdentifier:@"url" withClass:[NSString class]];
		[describer setChildForIdentifier:@"cookies" withClass:[NSString class]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"galleryId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"url" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"cookies" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFCreateVideoFromUrl (ValueProperties) 

- (int) galleryIdValue
{
	return [self.galleryId intValue];
}

- (void) setGalleryIdValue:(int) value
{
	self.galleryId = [NSNumber numberWithInt:value];
}
@end

