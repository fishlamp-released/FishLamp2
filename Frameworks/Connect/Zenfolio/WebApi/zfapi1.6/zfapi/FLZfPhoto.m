//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfPhoto.m
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfPhoto.h"
#import "FLZfAccessDescriptor.h"
#import "FLZfApi1_6Enums.h"
#import "FLZfApi1_6Enums.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"
#import "FLZfExifTag.h"
#import "FLZfParsedCategory.h"

@implementation FLZfPhoto


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
	((FLZfPhoto*)object).ShortExif = FLCopyOrRetainObject(_ShortExif);
	((FLZfPhoto*)object).MimeType = FLCopyOrRetainObject(_MimeType);
	((FLZfPhoto*)object).IsVideo = FLCopyOrRetainObject(_IsVideo);
	((FLZfPhoto*)object).Keywords = FLCopyOrRetainObject(_Keywords);
	((FLZfPhoto*)object).UrlHost = FLCopyOrRetainObject(_UrlHost);
	((FLZfPhoto*)object).Views = FLCopyOrRetainObject(_Views);
	((FLZfPhoto*)object).TextCn = FLCopyOrRetainObject(_TextCn);
	((FLZfPhoto*)object).categoryArray = FLCopyOrRetainObject(_categoryArray);
	((FLZfPhoto*)object).Rotation = FLCopyOrRetainObject(_Rotation);
	((FLZfPhoto*)object).Caption = FLCopyOrRetainObject(_Caption);
	((FLZfPhoto*)object).Sequence = FLCopyOrRetainObject(_Sequence);
	((FLZfPhoto*)object).Size = FLCopyOrRetainObject(_Size);
	((FLZfPhoto*)object).UploadedOn = FLCopyOrRetainObject(_UploadedOn);
	((FLZfPhoto*)object).UrlCore = FLCopyOrRetainObject(_UrlCore);
	((FLZfPhoto*)object).TakenOn = FLCopyOrRetainObject(_TakenOn);
	((FLZfPhoto*)object).Height = FLCopyOrRetainObject(_Height);
	((FLZfPhoto*)object).Gallery = FLCopyOrRetainObject(_Gallery);
	((FLZfPhoto*)object).Owner = FLCopyOrRetainObject(_Owner);
	((FLZfPhoto*)object).Duration = FLCopyOrRetainObject(_Duration);
	((FLZfPhoto*)object).UrlToken = FLCopyOrRetainObject(_UrlToken);
	((FLZfPhoto*)object).Title = FLCopyOrRetainObject(_Title);
	((FLZfPhoto*)object).PageUrl = FLCopyOrRetainObject(_PageUrl);
	((FLZfPhoto*)object).PricingKey = FLCopyOrRetainObject(_PricingKey);
	((FLZfPhoto*)object).FileHash = FLCopyOrRetainObject(_FileHash);
	((FLZfPhoto*)object).AccessDescriptor = FLCopyOrRetainObject(_AccessDescriptor);
	((FLZfPhoto*)object).Width = FLCopyOrRetainObject(_Width);
	((FLZfPhoto*)object).MailboxId = FLCopyOrRetainObject(_MailboxId);
	((FLZfPhoto*)object).FileName = FLCopyOrRetainObject(_FileName);
	((FLZfPhoto*)object).Flags = FLCopyOrRetainObject(_Flags);
	((FLZfPhoto*)object).OriginalUrl = FLCopyOrRetainObject(_OriginalUrl);
	((FLZfPhoto*)object).ExifTagsArray = FLCopyOrRetainObject(_ExifTagsArray);
	((FLZfPhoto*)object).Categories = FLCopyOrRetainObject(_Categories);
	((FLZfPhoto*)object).Id = FLCopyOrRetainObject(_Id);
	((FLZfPhoto*)object).Copyright = FLCopyOrRetainObject(_Copyright);
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

+ (FLZfPhoto*) photo
{
	return FLAutorelease([[FLZfPhoto alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Id" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"Id"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Width" propertyClass:[NSNumber class] propertyType:FLDataTypeUnsignedInteger] forPropertyName:@"Width"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Height" propertyClass:[NSNumber class] propertyType:FLDataTypeUnsignedInteger] forPropertyName:@"Height"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Sequence" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"Sequence"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"AccessDescriptor" propertyClass:[FLZfAccessDescriptor class] propertyType:FLDataTypeObject] forPropertyName:@"AccessDescriptor"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Title" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"Title"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Caption" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"Caption"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"FileName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"FileName"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"UploadedOn" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"UploadedOn"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"TakenOn" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"TakenOn"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Owner" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"Owner"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Gallery" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"Gallery"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Views" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"Views"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Size" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"Size"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Rotation" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"Rotation"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Keywords" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"Keyword" propertyClass:[NSString class] propertyType:FLDataTypeString arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"Keywords"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Categories" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"Category" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"Categories"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Flags" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"Flags"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"TextCn" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"TextCn"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"PricingKey" propertyClass:[NSNumber class] propertyType:FLDataTypeLong] forPropertyName:@"PricingKey"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"MimeType" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"MimeType"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"OriginalUrl" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"OriginalUrl"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"UrlCore" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"UrlCore"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"UrlHost" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"UrlHost"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"UrlToken" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"UrlToken"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Copyright" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"Copyright"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"FileHash" propertyClass:[NSData class] propertyType:FLDataTypeData] forPropertyName:@"FileHash"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"PageUrl" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"PageUrl"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"ExifTagsArray" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"ExifTags" propertyClass:[FLZfExifTag class] propertyType:FLDataTypeObject arrayTypes:nil], nil] isUnboundedArray:YES] forPropertyName:@"ExifTagsArray"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"ShortExif" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"ShortExif"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"MailboxId" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"MailboxId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"IsVideo" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"IsVideo"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Duration" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"Duration"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"categoryArray" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"parsedCategory" propertyClass:[FLZfParsedCategory class] propertyType:FLDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"categoryArray"];
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

@implementation FLZfPhoto (ValueProperties) 

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

- (FLZfPhotoRotation) RotationValue
{
	return [[FLZfApi1_6EnumLookup instance] photoRotationFromString:self.Rotation];
}

- (void) setRotationValue:(FLZfPhotoRotation) inEnumValue
{
	self.Rotation = [[FLZfApi1_6EnumLookup instance] stringFromPhotoRotation:inEnumValue];
}

- (FLZfPhotoFlags) FlagsValue
{
	return [[FLZfApi1_6EnumLookup instance] photoFlagsFromString:self.Flags];
}

- (void) setFlagsValue:(FLZfPhotoFlags) inEnumValue
{
	self.Flags = [[FLZfApi1_6EnumLookup instance] stringFromPhotoFlags:inEnumValue];
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

