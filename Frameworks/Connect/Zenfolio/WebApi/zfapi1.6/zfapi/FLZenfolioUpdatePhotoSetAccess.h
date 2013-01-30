//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUpdatePhotoSetAccess.h
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
// FLZenfolioUpdatePhotoSetAccess
// --------------------------------------------------------------------
@interface FLZenfolioUpdatePhotoSetAccess : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
	FLZenfolioAccessUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

@property (readwrite, retain, nonatomic) FLZenfolioAccessUpdater* updater;

+ (NSString*) photoSetIdKey;

+ (NSString*) updaterKey;

+ (FLZenfolioUpdatePhotoSetAccess*) updatePhotoSetAccess; 

@end

@interface FLZenfolioUpdatePhotoSetAccess (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;
@end

