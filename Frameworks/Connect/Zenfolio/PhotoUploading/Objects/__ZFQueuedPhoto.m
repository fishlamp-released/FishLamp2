//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFQueuedPhoto.m
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFQueuedPhoto.h"
#import "ZFAccessDescriptor.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFQueuedPhoto


@synthesize accessDescriptor = _accessDescriptor;
@synthesize categoryArray = _categoryArray;
@synthesize saveToDeviceBeforeUpload = _saveToDeviceBeforeUpload;
@synthesize scaledUploadSize = _scaledUploadSize;
@synthesize wasSavedToDeviceBeforeUpload = _wasSavedToDeviceBeforeUpload;
@synthesize zenfolioCategories = _zenfolioCategories;

+ (NSString*) accessDescriptorKey
{
	return @"accessDescriptor";
}

+ (NSString*) categoryArrayKey
{
	return @"categoryArray";
}

+ (NSString*) saveToDeviceBeforeUploadKey
{
	return @"saveToDeviceBeforeUpload";
}

+ (NSString*) scaledUploadSizeKey
{
	return @"scaledUploadSize";
}

+ (NSString*) wasSavedToDeviceBeforeUploadKey
{
	return @"wasSavedToDeviceBeforeUpload";
}

+ (NSString*) zenfolioCategoriesKey
{
	return @"zenfolioCategories";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFQueuedPhoto*)object).zenfolioCategories = FLCopyOrRetainObject(_zenfolioCategories);
	((ZFQueuedPhoto*)object).wasSavedToDeviceBeforeUpload = FLCopyOrRetainObject(_wasSavedToDeviceBeforeUpload);
	((ZFQueuedPhoto*)object).accessDescriptor = FLCopyOrRetainObject(_accessDescriptor);
	((ZFQueuedPhoto*)object).scaledUploadSize = FLCopyOrRetainObject(_scaledUploadSize);
	((ZFQueuedPhoto*)object).saveToDeviceBeforeUpload = FLCopyOrRetainObject(_saveToDeviceBeforeUpload);
	((ZFQueuedPhoto*)object).categoryArray = FLCopyOrRetainObject(_categoryArray);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_accessDescriptor);
	FLRelease(_categoryArray);
	FLRelease(_zenfolioCategories);
	FLRelease(_scaledUploadSize);
	FLRelease(_saveToDeviceBeforeUpload);
	FLRelease(_wasSavedToDeviceBeforeUpload);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_accessDescriptor) [aCoder encodeObject:_accessDescriptor forKey:@"_accessDescriptor"];
	if(_categoryArray) [aCoder encodeObject:_categoryArray forKey:@"_categoryArray"];
	if(_zenfolioCategories) [aCoder encodeObject:_zenfolioCategories forKey:@"_zenfolioCategories"];
	if(_scaledUploadSize) [aCoder encodeObject:_scaledUploadSize forKey:@"_scaledUploadSize"];
	if(_saveToDeviceBeforeUpload) [aCoder encodeObject:_saveToDeviceBeforeUpload forKey:@"_saveToDeviceBeforeUpload"];
	if(_wasSavedToDeviceBeforeUpload) [aCoder encodeObject:_wasSavedToDeviceBeforeUpload forKey:@"_wasSavedToDeviceBeforeUpload"];
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
		_accessDescriptor = FLRetain([aDecoder decodeObjectForKey:@"_accessDescriptor"]);
		_categoryArray = [[aDecoder decodeObjectForKey:@"_categoryArray"] mutableCopy];
		_zenfolioCategories = [[aDecoder decodeObjectForKey:@"_zenfolioCategories"] mutableCopy];
		_scaledUploadSize = FLRetain([aDecoder decodeObjectForKey:@"_scaledUploadSize"]);
		_saveToDeviceBeforeUpload = FLRetain([aDecoder decodeObjectForKey:@"_saveToDeviceBeforeUpload"]);
		_wasSavedToDeviceBeforeUpload = FLRetain([aDecoder decodeObjectForKey:@"_wasSavedToDeviceBeforeUpload"]);
	}
	return self;
}

+ (ZFQueuedPhoto*) queuedPhoto
{
	return FLAutorelease([[ZFQueuedPhoto alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
        

		[describer setChildForIdentifier:@"accessDescriptor" withClass:[ZFAccessDescriptor class]];
		[describer setChildForIdentifier:@"categoryArray" withClass:[NSMutableArray class]];
		[describer setChildForIdentifier:@"zenfolioCategories" withClass:[NSMutableArray class]];
		[describer setChildForIdentifier:@"scaledUploadSize" withClass:[FLIntegerNumber class] ];
		[describer setChildForIdentifier:@"saveToDeviceBeforeUpload" withClass:[FLBoolNumber class] ];
		[describer setChildForIdentifier:@"wasSavedToDeviceBeforeUpload" withClass:[FLBoolNumber class] ];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"accessDescriptor" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"categoryArray" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"zenfolioCategories" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"scaledUploadSize" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"saveToDeviceBeforeUpload" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"wasSavedToDeviceBeforeUpload" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFQueuedPhoto (ValueProperties) 

- (int) scaledUploadSizeValue
{
	return [self.scaledUploadSize intValue];
}

- (void) setScaledUploadSizeValue:(int) value
{
	self.scaledUploadSize = [NSNumber numberWithInt:value];
}

- (BOOL) saveToDeviceBeforeUploadValue
{
	return [self.saveToDeviceBeforeUpload boolValue];
}

- (void) setSaveToDeviceBeforeUploadValue:(BOOL) value
{
	self.saveToDeviceBeforeUpload = [NSNumber numberWithBool:value];
}

- (BOOL) wasSavedToDeviceBeforeUploadValue
{
	return [self.wasSavedToDeviceBeforeUpload boolValue];
}

- (void) setWasSavedToDeviceBeforeUploadValue:(BOOL) value
{
	self.wasSavedToDeviceBeforeUpload = [NSNumber numberWithBool:value];
}
@end

