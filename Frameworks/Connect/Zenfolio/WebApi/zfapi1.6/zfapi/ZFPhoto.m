//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFPhoto.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFPhoto.h"
#import "ZFAccessDescriptor.h"
#import "ZFApi1_6Enums.h"
#import "ZFApi1_6Enums.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "ZFExifTag.h"
#import "ZFParsedCategory.h"

@implementation ZFPhoto


@synthesize AccessDescriptor = _AccessDescriptor;
@synthesize Caption = _Caption;
@synthesize Categories = _Categories;
@synthesize Copyright = _Copyright;
@synthesize Duration = _Duration;
@synthesize ExifTagsArray = _ExifTagsArray;
@synthesize FileHash = _FileHash;
@synthesize FileName = _FileName;
@synthesize Flags = _Flags;
@synthesize Gallery = _Gallery;
@synthesize Height = _Height;
@synthesize Id = _Id;
@synthesize IsVideo = _IsVideo;
@synthesize Keywords = _Keywords;
@synthesize MailboxId = _MailboxId;
@synthesize MimeType = _MimeType;
@synthesize OriginalUrl = _OriginalUrl;
@synthesize Owner = _Owner;
@synthesize PageUrl = _PageUrl;
@synthesize PricingKey = _PricingKey;
@synthesize Rotation = _Rotation;
@synthesize Sequence = _Sequence;
@synthesize ShortExif = _ShortExif;
@synthesize Size = _Size;
@synthesize TakenOn = _TakenOn;
@synthesize TextCn = _TextCn;
@synthesize Title = _Title;
@synthesize UploadedOn = _UploadedOn;
@synthesize UrlCore = _UrlCore;
@synthesize UrlHost = _UrlHost;
@synthesize UrlToken = _UrlToken;
@synthesize Views = _Views;
@synthesize Width = _Width;
@synthesize categoryArray = _categoryArray;

+ (NSString*) AccessDescriptorKey
{
	return @"AccessDescriptor";
}

+ (NSString*) CaptionKey
{
	return @"Caption";
}

+ (NSString*) CategoriesKey
{
	return @"Categories";
}

+ (NSString*) CopyrightKey
{
	return @"Copyright";
}

+ (NSString*) DurationKey
{
	return @"Duration";
}

+ (NSString*) ExifTagsArrayKey
{
	return @"ExifTagsArray";
}

+ (NSString*) FileHashKey
{
	return @"FileHash";
}

+ (NSString*) FileNameKey
{
	return @"FileName";
}

+ (NSString*) FlagsKey
{
	return @"Flags";
}

+ (NSString*) GalleryKey
{
	return @"Gallery";
}

+ (NSString*) HeightKey
{
	return @"Height";
}

+ (NSString*) IdKey
{
	return @"Id";
}

+ (NSString*) IsVideoKey
{
	return @"IsVideo";
}

+ (NSString*) KeywordsKey
{
	return @"Keywords";
}

+ (NSString*) MailboxIdKey
{
	return @"MailboxId";
}

+ (NSString*) MimeTypeKey
{
	return @"MimeType";
}

+ (NSString*) OriginalUrlKey
{
	return @"OriginalUrl";
}

+ (NSString*) OwnerKey
{
	return @"Owner";
}

+ (NSString*) PageUrlKey
{
	return @"PageUrl";
}

+ (NSString*) PricingKeyKey
{
	return @"PricingKey";
}

+ (NSString*) RotationKey
{
	return @"Rotation";
}

+ (NSString*) SequenceKey
{
	return @"Sequence";
}

+ (NSString*) ShortExifKey
{
	return @"ShortExif";
}

+ (NSString*) SizeKey
{
	return @"Size";
}

+ (NSString*) TakenOnKey
{
	return @"TakenOn";
}

+ (NSString*) TextCnKey
{
	return @"TextCn";
}

+ (NSString*) TitleKey
{
	return @"Title";
}

+ (NSString*) UploadedOnKey
{
	return @"UploadedOn";
}

+ (NSString*) UrlCoreKey
{
	return @"UrlCore";
}

+ (NSString*) UrlHostKey
{
	return @"UrlHost";
}

+ (NSString*) UrlTokenKey
{
	return @"UrlToken";
}

+ (NSString*) ViewsKey
{
	return @"Views";
}

+ (NSString*) WidthKey
{
	return @"Width";
}

+ (NSString*) categoryArrayKey
{
	return @"categoryArray";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFPhoto*)object).ShortExif = FLCopyOrRetainObject(_ShortExif);
	((ZFPhoto*)object).MimeType = FLCopyOrRetainObject(_MimeType);
	((ZFPhoto*)object).IsVideo = FLCopyOrRetainObject(_IsVideo);
	((ZFPhoto*)object).Keywords = FLCopyOrRetainObject(_Keywords);
	((ZFPhoto*)object).UrlHost = FLCopyOrRetainObject(_UrlHost);
	((ZFPhoto*)object).Views = FLCopyOrRetainObject(_Views);
	((ZFPhoto*)object).TextCn = FLCopyOrRetainObject(_TextCn);
	((ZFPhoto*)object).categoryArray = FLCopyOrRetainObject(_categoryArray);
	((ZFPhoto*)object).Rotation = FLCopyOrRetainObject(_Rotation);
	((ZFPhoto*)object).Caption = FLCopyOrRetainObject(_Caption);
	((ZFPhoto*)object).Sequence = FLCopyOrRetainObject(_Sequence);
	((ZFPhoto*)object).Size = FLCopyOrRetainObject(_Size);
	((ZFPhoto*)object).UploadedOn = FLCopyOrRetainObject(_UploadedOn);
	((ZFPhoto*)object).UrlCore = FLCopyOrRetainObject(_UrlCore);
	((ZFPhoto*)object).TakenOn = FLCopyOrRetainObject(_TakenOn);
	((ZFPhoto*)object).Height = FLCopyOrRetainObject(_Height);
	((ZFPhoto*)object).Gallery = FLCopyOrRetainObject(_Gallery);
	((ZFPhoto*)object).Owner = FLCopyOrRetainObject(_Owner);
	((ZFPhoto*)object).Duration = FLCopyOrRetainObject(_Duration);
	((ZFPhoto*)object).UrlToken = FLCopyOrRetainObject(_UrlToken);
	((ZFPhoto*)object).Title = FLCopyOrRetainObject(_Title);
	((ZFPhoto*)object).PageUrl = FLCopyOrRetainObject(_PageUrl);
	((ZFPhoto*)object).PricingKey = FLCopyOrRetainObject(_PricingKey);
	((ZFPhoto*)object).FileHash = FLCopyOrRetainObject(_FileHash);
	((ZFPhoto*)object).AccessDescriptor = FLCopyOrRetainObject(_AccessDescriptor);
	((ZFPhoto*)object).Width = FLCopyOrRetainObject(_Width);
	((ZFPhoto*)object).MailboxId = FLCopyOrRetainObject(_MailboxId);
	((ZFPhoto*)object).FileName = FLCopyOrRetainObject(_FileName);
	((ZFPhoto*)object).Flags = FLCopyOrRetainObject(_Flags);
	((ZFPhoto*)object).OriginalUrl = FLCopyOrRetainObject(_OriginalUrl);
	((ZFPhoto*)object).ExifTagsArray = FLCopyOrRetainObject(_ExifTagsArray);
	((ZFPhoto*)object).Categories = FLCopyOrRetainObject(_Categories);
	((ZFPhoto*)object).Id = FLCopyOrRetainObject(_Id);
	((ZFPhoto*)object).Copyright = FLCopyOrRetainObject(_Copyright);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_Id);
	FLRelease(_Width);
	FLRelease(_Height);
	FLRelease(_Sequence);
	FLRelease(_AccessDescriptor);
	FLRelease(_Title);
	FLRelease(_Caption);
	FLRelease(_FileName);
	FLRelease(_UploadedOn);
	FLRelease(_TakenOn);
	FLRelease(_Owner);
	FLRelease(_Gallery);
	FLRelease(_Views);
	FLRelease(_Size);
	FLRelease(_Rotation);
	FLRelease(_Keywords);
	FLRelease(_Categories);
	FLRelease(_Flags);
	FLRelease(_TextCn);
	FLRelease(_PricingKey);
	FLRelease(_MimeType);
	FLRelease(_OriginalUrl);
	FLRelease(_UrlCore);
	FLRelease(_UrlHost);
	FLRelease(_UrlToken);
	FLRelease(_Copyright);
	FLRelease(_FileHash);
	FLRelease(_PageUrl);
	FLRelease(_ExifTagsArray);
	FLRelease(_ShortExif);
	FLRelease(_MailboxId);
	FLRelease(_IsVideo);
	FLRelease(_Duration);
	FLRelease(_categoryArray);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_Id) [aCoder encodeObject:_Id forKey:@"_Id"];
	if(_Width) [aCoder encodeObject:_Width forKey:@"_Width"];
	if(_Height) [aCoder encodeObject:_Height forKey:@"_Height"];
	if(_Sequence) [aCoder encodeObject:_Sequence forKey:@"_Sequence"];
	if(_AccessDescriptor) [aCoder encodeObject:_AccessDescriptor forKey:@"_AccessDescriptor"];
	if(_Title) [aCoder encodeObject:_Title forKey:@"_Title"];
	if(_Caption) [aCoder encodeObject:_Caption forKey:@"_Caption"];
	if(_FileName) [aCoder encodeObject:_FileName forKey:@"_FileName"];
	if(_UploadedOn) [aCoder encodeObject:_UploadedOn forKey:@"_UploadedOn"];
	if(_TakenOn) [aCoder encodeObject:_TakenOn forKey:@"_TakenOn"];
	if(_Owner) [aCoder encodeObject:_Owner forKey:@"_Owner"];
	if(_Gallery) [aCoder encodeObject:_Gallery forKey:@"_Gallery"];
	if(_Views) [aCoder encodeObject:_Views forKey:@"_Views"];
	if(_Size) [aCoder encodeObject:_Size forKey:@"_Size"];
	if(_Rotation) [aCoder encodeObject:_Rotation forKey:@"_Rotation"];
	if(_Keywords) [aCoder encodeObject:_Keywords forKey:@"_Keywords"];
	if(_Categories) [aCoder encodeObject:_Categories forKey:@"_Categories"];
	if(_Flags) [aCoder encodeObject:_Flags forKey:@"_Flags"];
	if(_TextCn) [aCoder encodeObject:_TextCn forKey:@"_TextCn"];
	if(_PricingKey) [aCoder encodeObject:_PricingKey forKey:@"_PricingKey"];
	if(_MimeType) [aCoder encodeObject:_MimeType forKey:@"_MimeType"];
	if(_OriginalUrl) [aCoder encodeObject:_OriginalUrl forKey:@"_OriginalUrl"];
	if(_UrlCore) [aCoder encodeObject:_UrlCore forKey:@"_UrlCore"];
	if(_UrlHost) [aCoder encodeObject:_UrlHost forKey:@"_UrlHost"];
	if(_UrlToken) [aCoder encodeObject:_UrlToken forKey:@"_UrlToken"];
	if(_Copyright) [aCoder encodeObject:_Copyright forKey:@"_Copyright"];
	if(_FileHash) [aCoder encodeObject:_FileHash forKey:@"_FileHash"];
	if(_PageUrl) [aCoder encodeObject:_PageUrl forKey:@"_PageUrl"];
	if(_ExifTagsArray) [aCoder encodeObject:_ExifTagsArray forKey:@"_ExifTagsArray"];
	if(_ShortExif) [aCoder encodeObject:_ShortExif forKey:@"_ShortExif"];
	if(_MailboxId) [aCoder encodeObject:_MailboxId forKey:@"_MailboxId"];
	if(_IsVideo) [aCoder encodeObject:_IsVideo forKey:@"_IsVideo"];
	if(_Duration) [aCoder encodeObject:_Duration forKey:@"_Duration"];
	if(_categoryArray) [aCoder encodeObject:_categoryArray forKey:@"_categoryArray"];
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
		_Id = FLRetain([aDecoder decodeObjectForKey:@"_Id"]);
		_Width = FLRetain([aDecoder decodeObjectForKey:@"_Width"]);
		_Height = FLRetain([aDecoder decodeObjectForKey:@"_Height"]);
		_Sequence = FLRetain([aDecoder decodeObjectForKey:@"_Sequence"]);
		_AccessDescriptor = FLRetain([aDecoder decodeObjectForKey:@"_AccessDescriptor"]);
		_Title = FLRetain([aDecoder decodeObjectForKey:@"_Title"]);
		_Caption = FLRetain([aDecoder decodeObjectForKey:@"_Caption"]);
		_FileName = FLRetain([aDecoder decodeObjectForKey:@"_FileName"]);
		_UploadedOn = FLRetain([aDecoder decodeObjectForKey:@"_UploadedOn"]);
		_TakenOn = FLRetain([aDecoder decodeObjectForKey:@"_TakenOn"]);
		_Owner = FLRetain([aDecoder decodeObjectForKey:@"_Owner"]);
		_Gallery = FLRetain([aDecoder decodeObjectForKey:@"_Gallery"]);
		_Views = FLRetain([aDecoder decodeObjectForKey:@"_Views"]);
		_Size = FLRetain([aDecoder decodeObjectForKey:@"_Size"]);
		_Rotation = FLRetain([aDecoder decodeObjectForKey:@"_Rotation"]);
		_Keywords = [[aDecoder decodeObjectForKey:@"_Keywords"] mutableCopy];
		_Categories = [[aDecoder decodeObjectForKey:@"_Categories"] mutableCopy];
		_Flags = FLRetain([aDecoder decodeObjectForKey:@"_Flags"]);
		_TextCn = FLRetain([aDecoder decodeObjectForKey:@"_TextCn"]);
		_PricingKey = FLRetain([aDecoder decodeObjectForKey:@"_PricingKey"]);
		_MimeType = FLRetain([aDecoder decodeObjectForKey:@"_MimeType"]);
		_OriginalUrl = FLRetain([aDecoder decodeObjectForKey:@"_OriginalUrl"]);
		_UrlCore = FLRetain([aDecoder decodeObjectForKey:@"_UrlCore"]);
		_UrlHost = FLRetain([aDecoder decodeObjectForKey:@"_UrlHost"]);
		_UrlToken = FLRetain([aDecoder decodeObjectForKey:@"_UrlToken"]);
		_Copyright = FLRetain([aDecoder decodeObjectForKey:@"_Copyright"]);
		_FileHash = FLRetain([aDecoder decodeObjectForKey:@"_FileHash"]);
		_PageUrl = FLRetain([aDecoder decodeObjectForKey:@"_PageUrl"]);
		_ExifTagsArray = [[aDecoder decodeObjectForKey:@"_ExifTagsArray"] mutableCopy];
		_ShortExif = FLRetain([aDecoder decodeObjectForKey:@"_ShortExif"]);
		_MailboxId = FLRetain([aDecoder decodeObjectForKey:@"_MailboxId"]);
		_IsVideo = FLRetain([aDecoder decodeObjectForKey:@"_IsVideo"]);
		_Duration = FLRetain([aDecoder decodeObjectForKey:@"_Duration"]);
		_categoryArray = [[aDecoder decodeObjectForKey:@"_categoryArray"] mutableCopy];
	}
	return self;
}

+ (ZFPhoto*) photo
{
	return FLAutorelease([[ZFPhoto alloc] init]);
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
		[s_describer addChildDescriberWithName:@"Id" withClass:[FLIntegerNumber class] ];
		[s_describer addChildDescriberWithName:@"Width" withClass:[FLUnsignedIntegerNumber class] ];
		[s_describer addChildDescriberWithName:@"Height" withClass:[FLUnsignedIntegerNumber class] ];
		[s_describer addChildDescriberWithName:@"Sequence" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"AccessDescriptor" withClass:[ZFAccessDescriptor class]];
		[s_describer addChildDescriberWithName:@"Title" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"Caption" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"FileName" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"UploadedOn" withClass:[NSDate class]];
		[s_describer addChildDescriberWithName:@"TakenOn" withClass:[NSDate class]];
		[s_describer addChildDescriberWithName:@"Owner" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"Gallery" withClass:[FLIntegerNumber class] ];
		[s_describer addChildDescriberWithName:@"Views" withClass:[FLIntegerNumber class] ];
		[s_describer addChildDescriberWithName:@"Size" withClass:[FLIntegerNumber class] ];
		[s_describer addChildDescriberWithName:@"Rotation" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"Keywords" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"Keyword" objectClass:[NSString class] ], nil]];
		[s_describer addChildDescriberWithName:@"Categories" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"Category" objectClass:[FLIntegerNumber class]], nil]];
		[s_describer addChildDescriberWithName:@"Flags" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"TextCn" withClass:[FLIntegerNumber class] ];
		[s_describer addChildDescriberWithName:@"PricingKey" withClass:[FLLongNumber class] ];
		[s_describer addChildDescriberWithName:@"MimeType" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"OriginalUrl" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"UrlCore" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"UrlHost" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"UrlToken" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"Copyright" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"FileHash" withClass:[NSData class]];
		[s_describer addChildDescriberWithName:@"PageUrl" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"ExifTagsArray" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"ExifTags" objectClass:[ZFExifTag class]], nil]];
		[s_describer addChildDescriberWithName:@"ShortExif" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"MailboxId" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"IsVideo" withClass:[FLBoolNumber class] ];
		[s_describer addChildDescriberWithName:@"Duration" withClass:[FLIntegerNumber class] ];
		[s_describer addChildDescriberWithName:@"categoryArray" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"parsedCategory" objectClass:[ZFParsedCategory class]], nil]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Id" columnType:FLDatabaseTypeInteger columnConstraints:[NSArray arrayWithObject:[FLDatabaseColumn primaryKeyConstraint]]]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Width" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Height" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Sequence" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"AccessDescriptor" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Title" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Caption" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"FileName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"UploadedOn" columnType:FLDatabaseTypeDate columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"TakenOn" columnType:FLDatabaseTypeDate columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Owner" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Gallery" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Views" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Size" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Rotation" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Keywords" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Categories" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Flags" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"TextCn" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PricingKey" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"MimeType" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"OriginalUrl" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"UrlCore" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"UrlHost" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"UrlToken" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Copyright" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"FileHash" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PageUrl" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"ExifTagsArray" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"ShortExif" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"MailboxId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"IsVideo" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Duration" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"categoryArray" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFPhoto (ValueProperties) 

- (int) IdValue
{
	return [self.Id intValue];
}

- (void) setIdValue:(int) value
{
	self.Id = [NSNumber numberWithInt:value];
}

- (unsigned int) WidthValue
{
	return [self.Width unsignedIntValue];
}

- (void) setWidthValue:(unsigned int) value
{
	self.Width = [NSNumber numberWithUnsignedInt:value];
}

- (unsigned int) HeightValue
{
	return [self.Height unsignedIntValue];
}

- (void) setHeightValue:(unsigned int) value
{
	self.Height = [NSNumber numberWithUnsignedInt:value];
}

- (int) GalleryValue
{
	return [self.Gallery intValue];
}

- (void) setGalleryValue:(int) value
{
	self.Gallery = [NSNumber numberWithInt:value];
}

- (int) ViewsValue
{
	return [self.Views intValue];
}

- (void) setViewsValue:(int) value
{
	self.Views = [NSNumber numberWithInt:value];
}

- (int) SizeValue
{
	return [self.Size intValue];
}

- (void) setSizeValue:(int) value
{
	self.Size = [NSNumber numberWithInt:value];
}

- (ZFPhotoRotation) RotationValue
{
	return [[ZFApi1_6EnumLookup instance] photoRotationFromString:self.Rotation];
}

- (void) setRotationValue:(ZFPhotoRotation) inEnumValue
{
	self.Rotation = [[ZFApi1_6EnumLookup instance] stringFromPhotoRotation:inEnumValue];
}

- (ZFPhotoFlags) FlagsValue
{
	return [[ZFApi1_6EnumLookup instance] photoFlagsFromString:self.Flags];
}

- (void) setFlagsValue:(ZFPhotoFlags) inEnumValue
{
	self.Flags = [[ZFApi1_6EnumLookup instance] stringFromPhotoFlags:inEnumValue];
}

- (int) TextCnValue
{
	return [self.TextCn intValue];
}

- (void) setTextCnValue:(int) value
{
	self.TextCn = [NSNumber numberWithInt:value];
}

- (long) PricingKeyValue
{
	return [self.PricingKey longValue];
}

- (void) setPricingKeyValue:(long) value
{
	self.PricingKey = [NSNumber numberWithLong:value];
}

- (BOOL) IsVideoValue
{
	return [self.IsVideo boolValue];
}

- (void) setIsVideoValue:(BOOL) value
{
	self.IsVideo = [NSNumber numberWithBool:value];
}

- (int) DurationValue
{
	return [self.Duration intValue];
}

- (void) setDurationValue:(int) value
{
	self.Duration = [NSNumber numberWithInt:value];
}
@end
