//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfUpdatePhotoSetAccess.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfAccessUpdater;

// --------------------------------------------------------------------
// FLZfUpdatePhotoSetAccess
// --------------------------------------------------------------------
@interface FLZfUpdatePhotoSetAccess : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
	FLZfAccessUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

@property (readwrite, retain, nonatomic) FLZfAccessUpdater* updater;

+ (NSString*) photoSetIdKey;

+ (NSString*) updaterKey;

+ (FLZfUpdatePhotoSetAccess*) updatePhotoSetAccess; 

@end

@interface FLZfUpdatePhotoSetAccess (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;
@end

