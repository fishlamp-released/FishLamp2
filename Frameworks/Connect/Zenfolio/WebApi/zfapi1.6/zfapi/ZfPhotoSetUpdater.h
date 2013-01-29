//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFPhotoSetUpdater.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFPhotoSetUpdater
// --------------------------------------------------------------------
@interface ZFPhotoSetUpdater : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _Title;
	NSString* _Caption;
	NSMutableArray* _Keywords;
	NSMutableArray* _Categories;
	NSString* _CustomReference;
} 


@property (readwrite, retain, nonatomic) NSString* Caption;

@property (readwrite, retain, nonatomic) NSMutableArray* Categories;
// Type: NSNumber*, forKey: Category

@property (readwrite, retain, nonatomic) NSString* CustomReference;

@property (readwrite, retain, nonatomic) NSMutableArray* Keywords;
// Type: NSString*, forKey: Keyword

@property (readwrite, retain, nonatomic) NSString* Title;

+ (NSString*) CaptionKey;

+ (NSString*) CategoriesKey;

+ (NSString*) CustomReferenceKey;

+ (NSString*) KeywordsKey;

+ (NSString*) TitleKey;

+ (ZFPhotoSetUpdater*) photoSetUpdater; 

@end

@interface ZFPhotoSetUpdater (ValueProperties) 
@end

