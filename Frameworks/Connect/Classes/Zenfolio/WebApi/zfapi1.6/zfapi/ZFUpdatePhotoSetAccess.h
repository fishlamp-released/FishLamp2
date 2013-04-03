//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdatePhotoSetAccess.h
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
// ZFUpdatePhotoSetAccess
// --------------------------------------------------------------------
@interface ZFUpdatePhotoSetAccess : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
	ZFAccessUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

@property (readwrite, retain, nonatomic) ZFAccessUpdater* updater;

+ (NSString*) photoSetIdKey;

+ (NSString*) updaterKey;

+ (ZFUpdatePhotoSetAccess*) updatePhotoSetAccess; 

@end

@interface ZFUpdatePhotoSetAccess (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;
@end

