//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdatePhotoAccess.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class ZFAccessUpdater;

// --------------------------------------------------------------------
// ZFUpdatePhotoAccess
// --------------------------------------------------------------------
@interface ZFUpdatePhotoAccess : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoId;
	ZFAccessUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoId;

@property (readwrite, retain, nonatomic) ZFAccessUpdater* updater;

+ (NSString*) photoIdKey;

+ (NSString*) updaterKey;

+ (ZFUpdatePhotoAccess*) updatePhotoAccess; 

@end

@interface ZFUpdatePhotoAccess (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoIdValue;
@end
