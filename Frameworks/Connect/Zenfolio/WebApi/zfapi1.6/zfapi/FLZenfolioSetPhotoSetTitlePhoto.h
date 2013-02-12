//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioSetPhotoSetTitlePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioSetPhotoSetTitlePhoto
// --------------------------------------------------------------------
@interface FLZenfolioSetPhotoSetTitlePhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
	NSNumber* _photoId;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoId;

@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

+ (NSString*) photoIdKey;

+ (NSString*) photoSetIdKey;

+ (FLZenfolioSetPhotoSetTitlePhoto*) setPhotoSetTitlePhoto; 

@end

@interface FLZenfolioSetPhotoSetTitlePhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;

@property (readwrite, assign, nonatomic) int photoIdValue;
@end

