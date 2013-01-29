//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfUpdatePhotoAccess.h
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
// FLZfUpdatePhotoAccess
// --------------------------------------------------------------------
@interface FLZfUpdatePhotoAccess : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoId;
	FLZfAccessUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoId;

@property (readwrite, retain, nonatomic) FLZfAccessUpdater* updater;

+ (NSString*) photoIdKey;

+ (NSString*) updaterKey;

+ (FLZfUpdatePhotoAccess*) updatePhotoAccess; 

@end

@interface FLZfUpdatePhotoAccess (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoIdValue;
@end

