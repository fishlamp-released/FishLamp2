//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreatePhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


#import "ZFApi1_6Enums.h"
@class ZFPhotoSetUpdater;

// --------------------------------------------------------------------
// ZFCreatePhotoSet
// --------------------------------------------------------------------
@interface ZFCreatePhotoSet : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
	NSString* _type;
	ZFPhotoSetUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* groupId;

@property (readwrite, retain, nonatomic) NSString* type;

@property (readwrite, retain, nonatomic) ZFPhotoSetUpdater* updater;

+ (NSString*) groupIdKey;

+ (NSString*) typeKey;

+ (NSString*) updaterKey;

+ (ZFCreatePhotoSet*) createPhotoSet; 

@end

@interface ZFCreatePhotoSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;

@property (readwrite, assign, nonatomic) ZFPhotoSetType typeValue;
@end

