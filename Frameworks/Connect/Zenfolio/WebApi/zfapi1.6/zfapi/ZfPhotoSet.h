//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFPhotoSet.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


#import "ZFGroupElement.h"
#import "ZFApi1_6Enums.h"
@class ZFPhoto;

// --------------------------------------------------------------------
// ZFPhotoSet
// --------------------------------------------------------------------
@interface ZFPhotoSet : ZFGroupElement<NSCoding, NSCopying>{ 
@private
	NSString* _Caption;
	NSDate* _CreatedOn;
	NSDate* _ModifiedOn;
	NSNumber* _PhotoCount;
	NSNumber* _ImageCount;
	NSNumber* _VideoCount;
	NSNumber* _PhotoBytes;
	NSNumber* _Views;
	NSString* _Type;
	NSNumber* _FeaturedIndex;
	ZFPhoto* _TitlePhoto;
	NSNumber* _IsRandomTitlePhoto;
	NSMutableArray* _ParentGroups;
	NSMutableArray* _Photos;
	NSMutableArray* _Keywords;
	NSMutableArray* _Categories;
	NSString* _UploadUrl;
	NSString* _VideoUploadUrl;
	NSString* _PageUrl;
	NSString* _MailboxId;
	NSNumber* _TextCn;
	NSNumber* _PhotoListCn;
} 


@property (readwrite, retain, nonatomic) NSString* Caption;

@property (readwrite, retain, nonatomic) NSMutableArray* Categories;
// Type: NSNumber*, forKey: Category

@property (readwrite, retain, nonatomic) NSDate* CreatedOn;

@property (readwrite, retain, nonatomic) NSNumber* FeaturedIndex;

@property (readwrite, retain, nonatomic) NSNumber* ImageCount;

@property (readwrite, retain, nonatomic) NSNumber* IsRandomTitlePhoto;

@property (readwrite, retain, nonatomic) NSMutableArray* Keywords;
// Type: NSString*, forKey: Keyword

@property (readwrite, retain, nonatomic) NSString* MailboxId;

@property (readwrite, retain, nonatomic) NSDate* ModifiedOn;

@property (readwrite, retain, nonatomic) NSString* PageUrl;

@property (readwrite, retain, nonatomic) NSMutableArray* ParentGroups;
// Type: NSNumber*, forKey: Id

@property (readwrite, retain, nonatomic) NSNumber* PhotoBytes;

@property (readwrite, retain, nonatomic) NSNumber* PhotoCount;

@property (readwrite, retain, nonatomic) NSNumber* PhotoListCn;

@property (readwrite, retain, nonatomic) NSMutableArray* Photos;
// Type: ZFPhoto*, forKey: Photo

@property (readwrite, retain, nonatomic) NSNumber* TextCn;

@property (readwrite, retain, nonatomic) ZFPhoto* TitlePhoto;

@property (readwrite, retain, nonatomic) NSString* Type;

@property (readwrite, retain, nonatomic) NSString* UploadUrl;

@property (readwrite, retain, nonatomic) NSNumber* VideoCount;

@property (readwrite, retain, nonatomic) NSString* VideoUploadUrl;

@property (readwrite, retain, nonatomic) NSNumber* Views;

+ (NSString*) CaptionKey;

+ (NSString*) CategoriesKey;

+ (NSString*) CreatedOnKey;

+ (NSString*) FeaturedIndexKey;

+ (NSString*) ImageCountKey;

+ (NSString*) IsRandomTitlePhotoKey;

+ (NSString*) KeywordsKey;

+ (NSString*) MailboxIdKey;

+ (NSString*) ModifiedOnKey;

+ (NSString*) PageUrlKey;

+ (NSString*) ParentGroupsKey;

+ (NSString*) PhotoBytesKey;

+ (NSString*) PhotoCountKey;

+ (NSString*) PhotoListCnKey;

+ (NSString*) PhotosKey;

+ (NSString*) TextCnKey;

+ (NSString*) TitlePhotoKey;

+ (NSString*) TypeKey;

+ (NSString*) UploadUrlKey;

+ (NSString*) VideoCountKey;

+ (NSString*) VideoUploadUrlKey;

+ (NSString*) ViewsKey;

+ (ZFPhotoSet*) photoSet; 

@end

@interface ZFPhotoSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int PhotoCountValue;

@property (readwrite, assign, nonatomic) int ImageCountValue;

@property (readwrite, assign, nonatomic) int VideoCountValue;

@property (readwrite, assign, nonatomic) long PhotoBytesValue;

@property (readwrite, assign, nonatomic) int ViewsValue;

@property (readwrite, assign, nonatomic) ZFPhotoSetType TypeValue;

@property (readwrite, assign, nonatomic) int FeaturedIndexValue;

@property (readwrite, assign, nonatomic) BOOL IsRandomTitlePhotoValue;

@property (readwrite, assign, nonatomic) int TextCnValue;

@property (readwrite, assign, nonatomic) int PhotoListCnValue;
@end

