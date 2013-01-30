//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUpdatePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioPhotoUpdater;

// --------------------------------------------------------------------
// FLZenfolioUpdatePhoto
// --------------------------------------------------------------------
@interface FLZenfolioUpdatePhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoId;
	FLZenfolioPhotoUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoId;

@property (readwrite, retain, nonatomic) FLZenfolioPhotoUpdater* updater;

+ (NSString*) photoIdKey;

+ (NSString*) updaterKey;

+ (FLZenfolioUpdatePhoto*) updatePhoto; 

@end

@interface FLZenfolioUpdatePhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoIdValue;
@end

