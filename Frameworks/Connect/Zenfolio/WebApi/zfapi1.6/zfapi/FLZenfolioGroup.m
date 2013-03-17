//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGroup.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioGroup.h"
#import "FLZenfolioPhoto.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "FLZenfolioGroup.h"
#import "FLZenfolioPhotoSet.h"

@implementation FLZenfolioGroup


@synthesize Caption = _Caption;
@synthesize CollectionCount = _CollectionCount;
@synthesize CreatedOn = _CreatedOn;
@synthesize Elements = _Elements;
@synthesize GalleryCount = _GalleryCount;
@synthesize ImageCount = _ImageCount;
@synthesize ImmediateChildrenCount = _ImmediateChildrenCount;
@synthesize MailboxId = _MailboxId;
@synthesize ModifiedOn = _ModifiedOn;
@synthesize PageUrl = _PageUrl;
@synthesize ParentGroups = _ParentGroups;
@synthesize PhotoCount = _PhotoCount;
@synthesize SubGroupCount = _SubGroupCount;
@synthesize TextCn = _TextCn;
@synthesize TitlePhoto = _TitlePhoto;
@synthesize VideoCount = _VideoCount;

+ (NSString*) CaptionKey
{
	return @"Caption";
}

+ (NSString*) CollectionCountKey
{
	return @"CollectionCount";
}

+ (NSString*) CreatedOnKey
{
	return @"CreatedOn";
}

+ (NSString*) ElementsKey
{
	return @"Elements";
}

+ (NSString*) GalleryCountKey
{
	return @"GalleryCount";
}

+ (NSString*) ImageCountKey
{
	return @"ImageCount";
}

+ (NSString*) ImmediateChildrenCountKey
{
	return @"ImmediateChildrenCount";
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

+ (NSString*) PhotoCountKey
{
	return @"PhotoCount";
}

+ (NSString*) SubGroupCountKey
{
	return @"SubGroupCount";
}

+ (NSString*) TextCnKey
{
	return @"TextCn";
}

+ (NSString*) TitlePhotoKey
{
	return @"TitlePhoto";
}

+ (NSString*) VideoCountKey
{
	return @"VideoCount";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioGroup*)object).TextCn = FLCopyOrRetainObject(_TextCn);
	((FLZenfolioGroup*)object).Caption = FLCopyOrRetainObject(_Caption);
	((FLZenfolioGroup*)object).TitlePhoto = FLCopyOrRetainObject(_TitlePhoto);
	((FLZenfolioGroup*)object).PhotoCount = FLCopyOrRetainObject(_PhotoCount);
	((FLZenfolioGroup*)object).CollectionCount = FLCopyOrRetainObject(_CollectionCount);
	((FLZenfolioGroup*)object).CreatedOn = FLCopyOrRetainObject(_CreatedOn);
	((FLZenfolioGroup*)object).SubGroupCount = FLCopyOrRetainObject(_SubGroupCount);
	((FLZenfolioGroup*)object).PageUrl = FLCopyOrRetainObject(_PageUrl);
	((FLZenfolioGroup*)object).ParentGroups = FLCopyOrRetainObject(_ParentGroups);
	((FLZenfolioGroup*)object).ImageCount = FLCopyOrRetainObject(_ImageCount);
	((FLZenfolioGroup*)object).VideoCount = FLCopyOrRetainObject(_VideoCount);
	((FLZenfolioGroup*)object).Elements = FLCopyOrRetainObject(_Elements);
	((FLZenfolioGroup*)object).MailboxId = FLCopyOrRetainObject(_MailboxId);
	((FLZenfolioGroup*)object).GalleryCount = FLCopyOrRetainObject(_GalleryCount);
	((FLZenfolioGroup*)object).ImmediateChildrenCount = FLCopyOrRetainObject(_ImmediateChildrenCount);
	((FLZenfolioGroup*)object).ModifiedOn = FLCopyOrRetainObject(_ModifiedOn);
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
	FLRelease(_CollectionCount);
	FLRelease(_SubGroupCount);
	FLRelease(_GalleryCount);
	FLRelease(_PhotoCount);
	FLRelease(_ImageCount);
	FLRelease(_VideoCount);
	FLRelease(_ParentGroups);
	FLRelease(_Elements);
	FLRelease(_PageUrl);
	FLRelease(_TitlePhoto);
	FLRelease(_MailboxId);
	FLRelease(_TextCn);
	FLRelease(_ImmediateChildrenCount);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_Caption) [aCoder encodeObject:_Caption forKey:@"_Caption"];
	if(_CreatedOn) [aCoder encodeObject:_CreatedOn forKey:@"_CreatedOn"];
	if(_ModifiedOn) [aCoder encodeObject:_ModifiedOn forKey:@"_ModifiedOn"];
	if(_CollectionCount) [aCoder encodeObject:_CollectionCount forKey:@"_CollectionCount"];
	if(_SubGroupCount) [aCoder encodeObject:_SubGroupCount forKey:@"_SubGroupCount"];
	if(_GalleryCount) [aCoder encodeObject:_GalleryCount forKey:@"_GalleryCount"];
	if(_PhotoCount) [aCoder encodeObject:_PhotoCount forKey:@"_PhotoCount"];
	if(_ImageCount) [aCoder encodeObject:_ImageCount forKey:@"_ImageCount"];
	if(_VideoCount) [aCoder encodeObject:_VideoCount forKey:@"_VideoCount"];
	if(_ParentGroups) [aCoder encodeObject:_ParentGroups forKey:@"_ParentGroups"];
	if(_Elements) [aCoder encodeObject:_Elements forKey:@"_Elements"];
	if(_PageUrl) [aCoder encodeObject:_PageUrl forKey:@"_PageUrl"];
	if(_TitlePhoto) [aCoder encodeObject:_TitlePhoto forKey:@"_TitlePhoto"];
	if(_MailboxId) [aCoder encodeObject:_MailboxId forKey:@"_MailboxId"];
	if(_TextCn) [aCoder encodeObject:_TextCn forKey:@"_TextCn"];
	if(_ImmediateChildrenCount) [aCoder encodeObject:_ImmediateChildrenCount forKey:@"_ImmediateChildrenCount"];
	[super encodeWithCoder:aCoder];
}

+ (FLZenfolioGroup*) group
{
	return FLAutorelease([[FLZenfolioGroup alloc] init]);
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
		_CollectionCount = FLRetain([aDecoder decodeObjectForKey:@"_CollectionCount"]);
		_SubGroupCount = FLRetain([aDecoder decodeObjectForKey:@"_SubGroupCount"]);
		_GalleryCount = FLRetain([aDecoder decodeObjectForKey:@"_GalleryCount"]);
		_PhotoCount = FLRetain([aDecoder decodeObjectForKey:@"_PhotoCount"]);
		_ImageCount = FLRetain([aDecoder decodeObjectForKey:@"_ImageCount"]);
		_VideoCount = FLRetain([aDecoder decodeObjectForKey:@"_VideoCount"]);
		_ParentGroups = [[aDecoder decodeObjectForKey:@"_ParentGroups"] mutableCopy];
		_Elements = [[aDecoder decodeObjectForKey:@"_Elements"] mutableCopy];
		_PageUrl = FLRetain([aDecoder decodeObjectForKey:@"_PageUrl"]);
		_TitlePhoto = FLRetain([aDecoder decodeObjectForKey:@"_TitlePhoto"]);
		_MailboxId = FLRetain([aDecoder decodeObjectForKey:@"_MailboxId"]);
		_TextCn = FLRetain([aDecoder decodeObjectForKey:@"_TextCn"]);
		_ImmediateChildrenCount = FLRetain([aDecoder decodeObjectForKey:@"_ImmediateChildrenCount"]);
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
		[s_describer addProperty:@"Caption" withClass:[NSString class]];
		[s_describer addProperty:@"CreatedOn" withClass:[NSDate class]];
		[s_describer addProperty:@"ModifiedOn" withClass:[NSDate class]];
		[s_describer addProperty:@"CollectionCount" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"SubGroupCount" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"GalleryCount" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"PhotoCount" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"ImageCount" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"VideoCount" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"ParentGroups" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyType propertyType:@"Id" propertyClass:[FLIntegerNumber class]], nil]];
		[s_describer addProperty:@"Elements" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyType propertyType:@"Group" propertyClass:[FLZenfolioGroup class]], [FLPropertyType propertyType:@"PhotoSet" propertyClass:[FLZenfolioPhotoSet class]], nil]];
		[s_describer addProperty:@"PageUrl" withClass:[NSString class]];
		[s_describer addProperty:@"TitlePhoto" withClass:[FLZenfolioPhoto class]];
		[s_describer addProperty:@"MailboxId" withClass:[NSString class]];
		[s_describer addProperty:@"TextCn" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"ImmediateChildrenCount" withClass:[FLIntegerNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CollectionCount" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"SubGroupCount" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"GalleryCount" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PhotoCount" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"ImageCount" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"VideoCount" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"ParentGroups" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Elements" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PageUrl" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"TitlePhoto" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"MailboxId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"TextCn" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"ImmediateChildrenCount" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioGroup (ValueProperties) 

- (int) CollectionCountValue
{
	return [self.CollectionCount intValue];
}

- (void) setCollectionCountValue:(int) value
{
	self.CollectionCount = [NSNumber numberWithInt:value];
}

- (int) SubGroupCountValue
{
	return [self.SubGroupCount intValue];
}

- (void) setSubGroupCountValue:(int) value
{
	self.SubGroupCount = [NSNumber numberWithInt:value];
}

- (int) GalleryCountValue
{
	return [self.GalleryCount intValue];
}

- (void) setGalleryCountValue:(int) value
{
	self.GalleryCount = [NSNumber numberWithInt:value];
}

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

- (int) TextCnValue
{
	return [self.TextCn intValue];
}

- (void) setTextCnValue:(int) value
{
	self.TextCn = [NSNumber numberWithInt:value];
}

- (int) ImmediateChildrenCountValue
{
	return [self.ImmediateChildrenCount intValue];
}

- (void) setImmediateChildrenCountValue:(int) value
{
	self.ImmediateChildrenCount = [NSNumber numberWithInt:value];
}
@end

