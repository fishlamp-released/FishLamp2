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

FLSynthesizeModelObjectMethods();

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

- (void) dealloc
{
	FLRelease(_name);
	FLRelease(_photoSetId);
	FLRelease(_uploadUrl);
	FLSuperDealloc();
}

//+ (FLObjectDescriber*) objectDescriber {
//	static dispatch_once_t pred = 0;
//	dispatch_once(&pred, ^{
//        FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
//        
//		[describer setChildForIdentifier:@"name" withClass:[NSString class]];
//		[describer setChildForIdentifier:@"photoSetId" withClass:[FLIntegerNumber class] ];
//		[describer setChildForIdentifier:@"uploadUrl" withClass:[NSString class]];
//	});
//	return [FLObjectDescriber objectDescriber:[self class]];
//}

+ (void) objectDescriberWasRegistered:(FLObjectDescriber*) describer {
    [describer setChildForIdentifier:@"name" withClass:[NSString class]];
    [describer setChildForIdentifier:@"photoSetId" withClass:[FLIntegerNumber class] ];
    [describer setChildForIdentifier:@"uploadUrl" withClass:[NSString class]];
}

//+ (FLDatabaseTable*) sharedDatabaseTable
//
//{
//	static FLDatabaseTable* s_table = nil;
//	static dispatch_once_t pred = 0;
//	dispatch_once(&pred, ^{
//        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 
//
//		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"name" columnType:FLDatabaseTypeText columnConstraints:nil]];
//		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoSetId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
//		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadUrl" columnType:FLDatabaseTypeText columnConstraints:nil]];
//	});
//	return s_table;
//}

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

