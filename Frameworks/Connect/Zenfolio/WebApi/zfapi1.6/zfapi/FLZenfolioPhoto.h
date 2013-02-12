//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioPhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioAccessDescriptor;
#import "FLZenfolioApi1_6Enums.h"
#import "FLZenfolioApi1_6Enums.h"
@class FLZenfolioExifTag;
@class FLZenfolioParsedCategory;

// --------------------------------------------------------------------
// FLZenfolioPhoto
// --------------------------------------------------------------------
@interface FLZenfolioPhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _Id;
	NSNumber* _Width;
	NSNumber* _Height;
	NSString* _Sequence;
	FLZenfolioAccessDescriptor* _AccessDescriptor;
	NSString* _Title;
	NSString* _Caption;
	NSString* _FileName;
	NSDate* _UploadedOn;
	NSDate* _TakenOn;
	NSString* _Owner;
	NSNumber* _Gallery;
	NSNumber* _Views;
	NSNumber* _Size;
	NSString* _Rotation;
	NSMutableArray* _Keywords;
	NSMutableArray* _Categories;
	NSString* _Flags;
	NSNumber* _TextCn;
	NSNumber* _PricingKey;
	NSString* _MimeType;
	NSString* _OriginalUrl;
	NSString* _UrlCore;
	NSString* _UrlHost;
	NSString* _UrlToken;
	NSString* _Copyright;
	NSData* _FileHash;
	NSString* _PageUrl;
	NSMutableArray* _ExifTagsArray;
	NSString* _ShortExif;
	NSString* _MailboxId;
	NSNumber* _IsVideo;
	NSNumber* _Duration;
	NSMutableArray* _categoryArray;
} 


@property (readwrite, retain, nonatomic) FLZenfolioAccessDescriptor* AccessDescriptor;

@property (readwrite, retain, nonatomic) NSString* Caption;

@property (readwrite, retain, nonatomic) NSMutableArray* Categories;
// Type: NSNumber*, forKey: Category

@property (readwrite, retain, nonatomic) NSString* Copyright;

@property (readwrite, retain, nonatomic) NSNumber* Duration;

@property (readwrite, retain, nonatomic) NSMutableArray* ExifTagsArray;
// Type: FLZenfolioExifTag*, forKey: ExifTags

@property (readwrite, retain, nonatomic) NSData* FileHash;

@property (readwrite, retain, nonatomic) NSString* FileName;

@property (readwrite, retain, nonatomic) NSString* Flags;

@property (readwrite, retain, nonatomic) NSNumber* Gallery;

@property (readwrite, retain, nonatomic) NSNumber* Height;

@property (readwrite, retain, nonatomic) NSNumber* Id;

@property (readwrite, retain, nonatomic) NSNumber* IsVideo;

@property (readwrite, retain, nonatomic) NSMutableArray* Keywords;
// Type: NSString*, forKey: Keyword

@property (readwrite, retain, nonatomic) NSString* MailboxId;

@property (readwrite, retain, nonatomic) NSString* MimeType;

@property (readwrite, retain, nonatomic) NSString* OriginalUrl;

@property (readwrite, retain, nonatomic) NSString* Owner;

@property (readwrite, retain, nonatomic) NSString* PageUrl;

@property (readwrite, retain, nonatomic) NSNumber* PricingKey;

@property (readwrite, retain, nonatomic) NSString* Rotation;

@property (readwrite, retain, nonatomic) NSString* Sequence;

@property (readwrite, retain, nonatomic) NSString* ShortExif;

@property (readwrite, retain, nonatomic) NSNumber* Size;

@property (readwrite, retain, nonatomic) NSDate* TakenOn;

@property (readwrite, retain, nonatomic) NSNumber* TextCn;

@property (readwrite, retain, nonatomic) NSString* Title;

@property (readwrite, retain, nonatomic) NSDate* UploadedOn;

@property (readwrite, retain, nonatomic) NSString* UrlCore;

@property (readwrite, retain, nonatomic) NSString* UrlHost;

@property (readwrite, retain, nonatomic) NSString* UrlToken;

@property (readwrite, retain, nonatomic) NSNumber* Views;

@property (readwrite, retain, nonatomic) NSNumber* Width;

@property (readwrite, retain, nonatomic) NSMutableArray* categoryArray;
// Type: FLZenfolioParsedCategory*, forKey: parsedCategory

+ (NSString*) AccessDescriptorKey;

+ (NSString*) CaptionKey;

+ (NSString*) CategoriesKey;

+ (NSString*) CopyrightKey;

+ (NSString*) DurationKey;

+ (NSString*) ExifTagsArrayKey;

+ (NSString*) FileHashKey;

+ (NSString*) FileNameKey;

+ (NSString*) FlagsKey;

+ (NSString*) GalleryKey;

+ (NSString*) HeightKey;

+ (NSString*) IdKey;

+ (NSString*) IsVideoKey;

+ (NSString*) KeywordsKey;

+ (NSString*) MailboxIdKey;

+ (NSString*) MimeTypeKey;

+ (NSString*) OriginalUrlKey;

+ (NSString*) OwnerKey;

+ (NSString*) PageUrlKey;

+ (NSString*) PricingKeyKey;

+ (NSString*) RotationKey;

+ (NSString*) SequenceKey;

+ (NSString*) ShortExifKey;

+ (NSString*) SizeKey;

+ (NSString*) TakenOnKey;

+ (NSString*) TextCnKey;

+ (NSString*) TitleKey;

+ (NSString*) UploadedOnKey;

+ (NSString*) UrlCoreKey;

+ (NSString*) UrlHostKey;

+ (NSString*) UrlTokenKey;

+ (NSString*) ViewsKey;

+ (NSString*) WidthKey;

+ (NSString*) categoryArrayKey;

+ (FLZenfolioPhoto*) photo; 

@end

@interface FLZenfolioPhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int IdValue;

@property (readwrite, assign, nonatomic) unsigned int WidthValue;

@property (readwrite, assign, nonatomic) unsigned int HeightValue;

@property (readwrite, assign, nonatomic) int GalleryValue;

@property (readwrite, assign, nonatomic) int ViewsValue;

@property (readwrite, assign, nonatomic) int SizeValue;

@property (readwrite, assign, nonatomic) FLZenfolioPhotoRotation RotationValue;

@property (readwrite, assign, nonatomic) FLZenfolioPhotoFlags FlagsValue;

@property (readwrite, assign, nonatomic) int TextCnValue;

@property (readwrite, assign, nonatomic) long PricingKeyValue;

@property (readwrite, assign, nonatomic) BOOL IsVideoValue;

@property (readwrite, assign, nonatomic) int DurationValue;
@end

