//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGroup.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


#import "ZFGroupElement.h"
@class ZFPhoto;
@class ZFGroup;
@class ZFPhotoSet;

// --------------------------------------------------------------------
// ZFGroup
// --------------------------------------------------------------------
@interface ZFGroup : ZFGroupElement<NSCoding, NSCopying>{ 
@private
	NSString* _Caption;
	NSDate* _CreatedOn;
	NSDate* _ModifiedOn;
	NSNumber* _CollectionCount;
	NSNumber* _SubGroupCount;
	NSNumber* _GalleryCount;
	NSNumber* _PhotoCount;
	NSNumber* _ImageCount;
	NSNumber* _VideoCount;
	NSMutableArray* _ParentGroups;
	NSMutableArray* _Elements;
	NSString* _PageUrl;
	ZFPhoto* _TitlePhoto;
	NSString* _MailboxId;
	NSNumber* _TextCn;
	NSNumber* _ImmediateChildrenCount;
} 


@property (readwrite, retain, nonatomic) NSString* Caption;

@property (readwrite, retain, nonatomic) NSNumber* CollectionCount;

@property (readwrite, retain, nonatomic) NSDate* CreatedOn;

@property (readwrite, retain, nonatomic) NSMutableArray* Elements;
// Type: ZFGroup*, forKey: Group
// Type: ZFPhotoSet*, forKey: PhotoSet

@property (readwrite, retain, nonatomic) NSNumber* GalleryCount;

@property (readwrite, retain, nonatomic) NSNumber* ImageCount;

@property (readwrite, retain, nonatomic) NSNumber* ImmediateChildrenCount;

@property (readwrite, retain, nonatomic) NSString* MailboxId;

@property (readwrite, retain, nonatomic) NSDate* ModifiedOn;

@property (readwrite, retain, nonatomic) NSString* PageUrl;

@property (readwrite, retain, nonatomic) NSMutableArray* ParentGroups;
// Type: NSNumber*, forKey: Id

@property (readwrite, retain, nonatomic) NSNumber* PhotoCount;

@property (readwrite, retain, nonatomic) NSNumber* SubGroupCount;

@property (readwrite, retain, nonatomic) NSNumber* TextCn;

@property (readwrite, retain, nonatomic) ZFPhoto* TitlePhoto;

@property (readwrite, retain, nonatomic) NSNumber* VideoCount;

+ (NSString*) CaptionKey;

+ (NSString*) CollectionCountKey;

+ (NSString*) CreatedOnKey;

+ (NSString*) ElementsKey;

+ (NSString*) GalleryCountKey;

+ (NSString*) ImageCountKey;

+ (NSString*) ImmediateChildrenCountKey;

+ (NSString*) MailboxIdKey;

+ (NSString*) ModifiedOnKey;

+ (NSString*) PageUrlKey;

+ (NSString*) ParentGroupsKey;

+ (NSString*) PhotoCountKey;

+ (NSString*) SubGroupCountKey;

+ (NSString*) TextCnKey;

+ (NSString*) TitlePhotoKey;

+ (NSString*) VideoCountKey;

+ (ZFGroup*) group; 

@end

@interface ZFGroup (ValueProperties) 

@property (readwrite, assign, nonatomic) int CollectionCountValue;

@property (readwrite, assign, nonatomic) int SubGroupCountValue;

@property (readwrite, assign, nonatomic) int GalleryCountValue;

@property (readwrite, assign, nonatomic) int PhotoCountValue;

@property (readwrite, assign, nonatomic) int ImageCountValue;

@property (readwrite, assign, nonatomic) int VideoCountValue;

@property (readwrite, assign, nonatomic) int TextCnValue;

@property (readwrite, assign, nonatomic) int ImmediateChildrenCountValue;
@end

