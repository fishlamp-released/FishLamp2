//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdatePhotoSet.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFPhotoSetUpdater;

// --------------------------------------------------------------------
// ZFUpdatePhotoSet
// --------------------------------------------------------------------
@interface ZFUpdatePhotoSet : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
	ZFPhotoSetUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

@property (readwrite, retain, nonatomic) ZFPhotoSetUpdater* updater;

+ (NSString*) photoSetIdKey;

+ (NSString*) updaterKey;

+ (ZFUpdatePhotoSet*) updatePhotoSet; 

@end

@interface ZFUpdatePhotoSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;
@end

