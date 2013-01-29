//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfUpdatePhotoSet.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfPhotoSetUpdater;

// --------------------------------------------------------------------
// FLZfUpdatePhotoSet
// --------------------------------------------------------------------
@interface FLZfUpdatePhotoSet : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
	FLZfPhotoSetUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

@property (readwrite, retain, nonatomic) FLZfPhotoSetUpdater* updater;

+ (NSString*) photoSetIdKey;

+ (NSString*) updaterKey;

+ (FLZfUpdatePhotoSet*) updatePhotoSet; 

@end

@interface FLZfUpdatePhotoSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;
@end

