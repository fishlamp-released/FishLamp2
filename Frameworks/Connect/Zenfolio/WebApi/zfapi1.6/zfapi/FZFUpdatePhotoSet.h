//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUpdatePhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioPhotoSetUpdater;

// --------------------------------------------------------------------
// FLZenfolioUpdatePhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioUpdatePhotoSet : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
	FLZenfolioPhotoSetUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

@property (readwrite, retain, nonatomic) FLZenfolioPhotoSetUpdater* updater;

+ (NSString*) photoSetIdKey;

+ (NSString*) updaterKey;

+ (FLZenfolioUpdatePhotoSet*) updatePhotoSet; 

@end

@interface FLZenfolioUpdatePhotoSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;
@end

