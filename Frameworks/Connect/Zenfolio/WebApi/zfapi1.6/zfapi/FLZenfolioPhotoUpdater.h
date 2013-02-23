//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioPhotoUpdater.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioPhotoUpdater
// --------------------------------------------------------------------
@interface FLZenfolioPhotoUpdater : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _Title;
	NSString* _Caption;
	NSMutableArray* _Keywords;
	NSMutableArray* _Categories;
	NSString* _Copyright;
	NSString* _FileName;
} 


@property (readwrite, retain, nonatomic) NSString* Caption;

@property (readwrite, retain, nonatomic) NSMutableArray* Categories;
// Type: NSNumber*, forKey: Category

@property (readwrite, retain, nonatomic) NSString* Copyright;

@property (readwrite, retain, nonatomic) NSString* FileName;

@property (readwrite, retain, nonatomic) NSMutableArray* Keywords;
// Type: NSString*, forKey: Keyword

@property (readwrite, retain, nonatomic) NSString* Title;

+ (NSString*) CaptionKey;

+ (NSString*) CategoriesKey;

+ (NSString*) CopyrightKey;

+ (NSString*) FileNameKey;

+ (NSString*) KeywordsKey;

+ (NSString*) TitleKey;

+ (FLZenfolioPhotoUpdater*) photoUpdater; 

@end

@interface FLZenfolioPhotoUpdater (ValueProperties) 
@end
