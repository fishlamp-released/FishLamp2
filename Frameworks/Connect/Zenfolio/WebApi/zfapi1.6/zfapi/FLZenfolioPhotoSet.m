//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioPhotoSet.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioPhotoSet.h"
#import "FLZenfolioApi1_6Enums.h"
#import "FLZenfolioPhoto.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZenfolioPhotoSet


@synthesize Caption = _Caption;
@synthesize Categories = _Categories;
@synthesize CreatedOn = _CreatedOn;
@synthesize FeaturedIndex = _FeaturedIndex;
@synthesize ImageCount = _ImageCount;
@synthesize IsRandomTitlePhoto = _IsRandomTitlePhoto;
@synthesize Keywords = _Keywords;
@synthesize MailboxId = _MailboxId;
@synthesize ModifiedOn = _ModifiedOn;
@synthesize PageUrl = _PageUrl;
@synthesize ParentGroups = _ParentGroups;
@synthesize PhotoBytes = _PhotoBytes;
@synthesize PhotoCount = _PhotoCount;
@synthesize PhotoListCn = _PhotoListCn;
@synthesize Photos = _Photos;
@synthesize TextCn = _TextCn;
@synthesize TitlePhoto = _TitlePhoto;
@synthesize Type = _Type;
@synthesize UploadUrl = _UploadUrl;
@synthesize VideoCount = _VideoCount;
@synthesize VideoUploadUrl = _VideoUploadUrl;
@synthesize Views = _Views;

+ (NSString*) CaptionKey
{
	return @"Caption";
}

+ (NSString*) CategoriesKey
{
	return @"Categories";
}

+ (NSString*) CreatedOnKey
{
	return @"CreatedOn";
}

+ (NSString*) FeaturedIndexKey
{
	return @"FeaturedIndex";
}

+ (NSString*) ImageCountKey
{
	return @"ImageCount";
}

+ (NSString*) IsRandomTitlePhotoKey
{
	return @"IsRandomTitlePhoto";
}

+ (NSString*) KeywordsKey
{
	return @"Keywords";
}

+ (NSString*) MailboxIdKey
{
	return @"MailboxId";
}

+ (NSString*) ModifiedOnKey
{
	return @"ModifiedOn";
}

+ (NSString*) PageUrlKey
{
	return @"PageUrl";
}

+ (NSString*) ParentGroupsKey
{
	return @"ParentGroups";
}

+ (NSString*) PhotoBytesKey
{
	return @"PhotoBytes";
}

+ (NSString*) PhotoCountKey
{
	return @"PhotoCount";
}

+ (NSString*) PhotoListCnKey
{
	return @"PhotoListCn";
}

+ (NSString*) PhotosKey
{
	return @"Photos";
}

+ (NSString*) TextCnKey
{
	return @"TextCn";
}

+ (NSString*) TitlePhotoKey
{
	return @"TitlePhoto";
}

+ (NSString*) TypeKey
{
	return @"Type";
}

+ (NSString*) UploadUrlKey
{
	return @"UploadUrl";
}

+ (NSString*) VideoCountKey
{
	return @"VideoCount";
}

+ (NSString*) VideoUploadUrlKey
{
	return @"VideoUploadUrl";
}

+ (NSString*) ViewsKey
{
	return @"Views";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioPhotoSet*)object).Caption = FLCopyOrRetainObject(_Caption);
	((FLZenfolioPhotoSet*)object).TitlePhoto = FLCopyOrRetainObject(_TitlePhoto);
	((FLZenfolioPhotoSet*)object).ImageCount = FLCopyOrRetainObject(_ImageCount);
	((FLZenfolioPhotoSet*)object).PageUrl = FLCopyOrRetainObject(_PageUrl);
	((FLZenfolioPhotoSet*)object).PhotoListCn = FLCopyOrRetainObject(_PhotoListCn);
	((FLZenfolioPhotoSet*)object).ParentGroups = FLCopyOrRetainObject(_ParentGroups);
	((FLZenfolioPhotoSet*)object).Views = FLCopyOrRetainObject(_Views);
	((FLZenfolioPhotoSet*)object).Type = FLCopyOrRetainObject(_Type);
	((FLZenfolioPhotoSet*)object).UploadUrl = FLCopyOrRetainObject(_UploadUrl);
	((FLZenfolioPhotoSet*)object).TextCn = FLCopyOrRetainObject(_TextCn);
	((FLZenfolioPhotoSet*)object).VideoCount = FLCopyOrRetainObject(_VideoCount);
	((FLZenfolioPhotoSet*)object).FeaturedIndex = FLCopyOrRetainObject(_FeaturedIndex);
	((FLZenfolioPhotoSet*)object).IsRandomTitlePhoto = FLCopyOrRetainObject(_IsRandomTitlePhoto);
	((FLZenfolioPhotoSet*)object).Photos = FLCopyOrRetainObject(_Photos);
	((FLZenfolioPhotoSet*)object).Categories = FLCopyOrRetainObject(_Categories);
	((FLZenfolioPhotoSet*)object).MailboxId = FLCopyOrRetainObject(_MailboxId);
	((FLZenfolioPhotoSet*)object).Keywords = FLCopyOrRetainObject(_Keywords);
	((FLZenfolioPhotoSet*)object).ModifiedOn = FLCopyOrRetainObject(_ModifiedOn);
	((FLZenfolioPhotoSet*)object).VideoUploadUrl = FLCopyOrRetainObject(_VideoUploadUrl);
	((FLZenfolioPhotoSet*)object).CreatedOn = FLCopyOrRetainObject(_CreatedOn);
	((FLZenfolioPhotoSet*)object).PhotoCount = FLCopyOrRetainObject(_PhotoCount);
	((FLZenfolioPhotoSet*)object).PhotoBytes = FLCopyOrRetainObject(_PhotoBytes);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_Caption);
	FLRelease(_CreatedOn);
	FLRelease(_ModifiedOn);
	FLRelease(_PhotoCount);
	FLRelease(_ImageCount);
	FLRelease(_VideoCount);
	FLRelease(_PhotoBytes);
	FLRelease(_Views);
	FLRelease(_Type);
	FLRelease(_FeaturedIndex);
	FLRelease(_TitlePhoto);
	FLRelease(_IsRandomTitlePhoto);
	FLRelease(_ParentGroups);
	FLRelease(_Photos);
	FLRelease(_Keywords);
	FLRelease(_Categories);
	FLRelease(_UploadUrl);
	FLRelease(_VideoUploadUrl);
	FLRelease(_PageUrl);
	FLRelease(_MailboxId);
	FLRelease(_TextCn);
	FLRelease(_PhotoListCn);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_Caption) [aCoder encodeObject:_Caption forKey:@"_Caption"];
	if(_CreatedOn) [aCoder encodeObject:_CreatedOn forKey:@"_CreatedOn"];
	if(_ModifiedOn) [aCoder encodeObject:_ModifiedOn forKey:@"_ModifiedOn"];
	if(_PhotoCount) [aCoder encodeObject:_PhotoCount forKey:@"_PhotoCount"];
	if(_ImageCount) [aCoder encodeObject:_ImageCount forKey:@"_ImageCount"];
	if(_VideoCount) [aCoder encodeObject:_VideoCount forKey:@"_VideoCount"];
	if(_PhotoBytes) [aCoder encodeObject:_PhotoBytes forKey:@"_PhotoBytes"];
	if(_Views) [aCoder encodeObject:_Views forKey:@"_Views"];
	if(_Type) [aCoder encodeObject:_Type forKey:@"_Type"];
	if(_FeaturedIndex) [aCoder encodeObject:_FeaturedIndex forKey:@"_FeaturedIndex"];
	if(_TitlePhoto) [aCoder encodeObject:_TitlePhoto forKey:@"_TitlePhoto"];
	if(_IsRandomTitlePhoto) [aCoder encodeObject:_IsRandomTitlePhoto forKey:@"_IsRandomTitlePhoto"];
	if(_ParentGroups) [aCoder encodeObject:_ParentGroups forKey:@"_ParentGroups"];
	if(_Photos) [aCoder encodeObject:_Photos forKey:@"_Photos"];
	if(_Keywords) [aCoder encodeObject:_Keywords forKey:@"_Keywords"];
	if(_Categories) [aCoder encodeObject:_Categories forKey:@"_Categories"];
	if(_UploadUrl) [aCoder encodeObject:_UploadUrl forKey:@"_UploadUrl"];
	if(_VideoUploadUrl) [aCoder encodeObject:_VideoUploadUrl forKey:@"_VideoUploadUrl"];
	if(_PageUrl) [aCoder encodeObject:_PageUrl forKey:@"_PageUrl"];
	if(_MailboxId) [aCoder encodeObject:_MailboxId forKey:@"_MailboxId"];
	if(_TextCn) [aCoder encodeObject:_TextCn forKey:@"_TextCn"];
	if(_PhotoListCn) [aCoder encodeObject:_PhotoListCn forKey:@"_PhotoListCn"];
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
		_Caption = FLRetain([aDecoder decodeObjectForKey:@"_Caption"]);
		_CreatedOn = FLRetain([aDecoder decodeObjectForKey:@"_CreatedOn"]);
		_ModifiedOn = FLRetain([aDecoder decodeObjectForKey:@"_ModifiedOn"]);
		_PhotoCount = FLRetain([aDecoder decodeObjectForKey:@"_PhotoCount"]);
		_ImageCount = FLRetain([aDecoder decodeObjectForKey:@"_ImageCount"]);
		_VideoCount = FLRetain([aDecoder decodeObjectForKey:@"_VideoCount"]);
		_PhotoBytes = FLRetain([aDecoder decodeObjectForKey:@"_PhotoBytes"]);
		_Views = FLRetain([aDecoder decodeObjectForKey:@"_Views"]);
		_Type = FLRetain([aDecoder decodeObjectForKey:@"_Type"]);
		_FeaturedIndex = FLRetain([aDecoder decodeObjectForKey:@"_FeaturedIndex"]);
		_TitlePhoto = FLRetain([aDecoder decodeObjectForKey:@"_TitlePhoto"]);
		_IsRandomTitlePhoto = FLRetain([aDecoder decodeObjectForKey:@"_IsRandomTitlePhoto"]);
		_ParentGroups = [[aDecoder decodeObjectForKey:@"_ParentGroups"] mutableCopy];
		_Photos = [[aDecoder decodeObjectForKey:@"_Photos"] mutableCopy];
		_Keywords = [[aDecoder decodeObjectForKey:@"_Keywords"] mutableCopy];
		_Categories = [[aDecoder decodeObjectForKey:@"_Categories"] mutableCopy];
		_UploadUrl = FLRetain([aDecoder decodeObjectForKey:@"_UploadUrl"]);
		_VideoUploadUrl = FLRetain([aDecoder decodeObjectForKey:@"_VideoUploadUrl"]);
		_PageUrl = FLRetain([aDecoder decodeObjectForKey:@"_PageUrl"]);
		_MailboxId = FLRetain([aDecoder decodeObjectForKey:@"_MailboxId"]);
		_TextCn = FLRetain([aDecoder decodeObjectForKey:@"_TextCn"]);
		_PhotoListCn = FLRetain([aDecoder decodeObjectForKey:@"_PhotoListCn"]);
	}
	return self;
}

+ (FLZenfolioPhotoSet*) photoSet
{
	return FLAutorelease([[FLZenfolioPhotoSet alloc] init]);
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
		[s_describer addProperty:@"Caption" withClass:[NSString class]];
		[s_describer addProperty:@"CreatedOn" withClass:[NSDate class]];
		[s_describer addProperty:@"ModifiedOn" withClass:[NSDate class]];
		[s_describer addProperty:@"PhotoCount" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"ImageCount" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"VideoCount" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"PhotoBytes" withClass:[FLLongNumber class] ];
		[s_describer addProperty:@"Views" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"Type" withClass:[NSString class]];
		[s_describer addProperty:@"FeaturedIndex" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"TitlePhoto" withClass:[FLZenfolioPhoto class]];
		[s_describer addProperty:@"IsRandomTitlePhoto" withClass:[FLBoolNumber class] ];
		[s_describer addArrayProperty:@"ParentGroups" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyType propertyType:@"Id" propertyClass:[FLIntegerNumber class]], nil]];
		[s_describer addArrayProperty:@"Photos" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyType propertyType:@"Photo" propertyClass:[FLZenfolioPhoto class]], nil]];
		[s_describer addArrayProperty:@"Keywords" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyType propertyType:@"Keyword" propertyClass:[NSString class] ], nil]];
		[s_describer addArrayProperty:@"Categories" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyType propertyType:@"Category" propertyClass:[FLIntegerNumber class]], nil]];
		[s_describer addProperty:@"UploadUrl" withClass:[NSString class]];
		[s_describer addProperty:@"VideoUploadUrl" withClass:[NSString class]];
		[s_describer addProperty:@"PageUrl" withClass:[NSString class]];
		[s_describer addProperty:@"MailboxId" withClass:[NSString class]];
		[s_describer addProperty:@"TextCn" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"PhotoListCn" withClass:[FLIntegerNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Caption" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CreatedOn" columnType:FLDatabaseTypeDate columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"ModifiedOn" columnType:FLDatabaseTypeDate columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PhotoCount" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"ImageCount" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"VideoCount" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PhotoBytes" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Views" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Type" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"FeaturedIndex" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"TitlePhoto" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"IsRandomTitlePhoto" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"ParentGroups" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Photos" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Keywords" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Categories" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"UploadUrl" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"VideoUploadUrl" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PageUrl" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"MailboxId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"TextCn" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PhotoListCn" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioPhotoSet (ValueProperties) 

- (int) PhotoCountValue
{
	return [self.PhotoCount intValue];
}

- (void) setPhotoCountValue:(int) value
{
	self.PhotoCount = [NSNumber numberWithInt:value];
}

- (int) ImageCountValue
{
	return [self.ImageCount intValue];
}

- (void) setImageCountValue:(int) value
{
	self.ImageCount = [NSNumber numberWithInt:value];
}

- (int) VideoCountValue
{
	return [self.VideoCount intValue];
}

- (void) setVideoCountValue:(int) value
{
	self.VideoCount = [NSNumber numberWithInt:value];
}

- (long) PhotoBytesValue
{
	return [self.PhotoBytes longValue];
}

- (void) setPhotoBytesValue:(long) value
{
	self.PhotoBytes = [NSNumber numberWithLong:value];
}

- (int) ViewsValue
{
	return [self.Views intValue];
}

- (void) setViewsValue:(int) value
{
	self.Views = [NSNumber numberWithInt:value];
}

- (FLZenfolioPhotoSetType) TypeValue
{
	return [[FLZenfolioApi1_6EnumLookup instance] photoSetTypeFromString:self.Type];
}

- (void) setTypeValue:(FLZenfolioPhotoSetType) inEnumValue
{
	self.Type = [[FLZenfolioApi1_6EnumLookup instance] stringFromPhotoSetType:inEnumValue];
}

- (int) FeaturedIndexValue
{
	return [self.FeaturedIndex intValue];
}

- (void) setFeaturedIndexValue:(int) value
{
	self.FeaturedIndex = [NSNumber numberWithInt:value];
}

- (BOOL) IsRandomTitlePhotoValue
{
	return [self.IsRandomTitlePhoto boolValue];
}

- (void) setIsRandomTitlePhotoValue:(BOOL) value
{
	self.IsRandomTitlePhoto = [NSNumber numberWithBool:value];
}

- (int) TextCnValue
{
	return [self.TextCn intValue];
}

- (void) setTextCnValue:(int) value
{
	self.TextCn = [NSNumber numberWithInt:value];
}

- (int) PhotoListCnValue
{
	return [self.PhotoListCn intValue];
}

- (void) setPhotoListCnValue:(int) value
{
	self.PhotoListCn = [NSNumber numberWithInt:value];
}
@end

