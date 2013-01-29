//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfUpdatePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfPhotoUpdater;

// --------------------------------------------------------------------
// FLZfUpdatePhoto
// --------------------------------------------------------------------
@interface FLZfUpdatePhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoId;
	FLZfPhotoUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoId;

@property (readwrite, retain, nonatomic) FLZfPhotoUpdater* updater;

+ (NSString*) photoIdKey;

+ (NSString*) updaterKey;

+ (FLZfUpdatePhoto*) updatePhoto; 

@end

@interface FLZfUpdatePhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoIdValue;
@end

