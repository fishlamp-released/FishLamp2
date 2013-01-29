//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdatePhoto.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFPhotoUpdater;

// --------------------------------------------------------------------
// ZFUpdatePhoto
// --------------------------------------------------------------------
@interface ZFUpdatePhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoId;
	ZFPhotoUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoId;

@property (readwrite, retain, nonatomic) ZFPhotoUpdater* updater;

+ (NSString*) photoIdKey;

+ (NSString*) updaterKey;

+ (ZFUpdatePhoto*) updatePhoto; 

@end

@interface ZFUpdatePhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoIdValue;
@end

