//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUpdatePhotoAccess.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioAccessUpdater;

// --------------------------------------------------------------------
// FLZenfolioUpdatePhotoAccess
// --------------------------------------------------------------------
@interface FLZenfolioUpdatePhotoAccess : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoId;
	FLZenfolioAccessUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoId;

@property (readwrite, retain, nonatomic) FLZenfolioAccessUpdater* updater;

+ (NSString*) photoIdKey;

+ (NSString*) updaterKey;

+ (FLZenfolioUpdatePhotoAccess*) updatePhotoAccess; 

@end

@interface FLZenfolioUpdatePhotoAccess (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoIdValue;
@end

