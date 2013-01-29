//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCreatePhotoSet.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


#import "FLZfApi1_6Enums.h"
@class FLZfPhotoSetUpdater;

// --------------------------------------------------------------------
// FLZfCreatePhotoSet
// --------------------------------------------------------------------
@interface FLZfCreatePhotoSet : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
	NSString* _type;
	FLZfPhotoSetUpdater* _updater;
} 


@property (readwrite, retain, nonatomic) NSNumber* groupId;

@property (readwrite, retain, nonatomic) NSString* type;

@property (readwrite, retain, nonatomic) FLZfPhotoSetUpdater* updater;

+ (NSString*) groupIdKey;

+ (NSString*) typeKey;

+ (NSString*) updaterKey;

+ (FLZfCreatePhotoSet*) createPhotoSet; 

@end

@interface FLZfCreatePhotoSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;

@property (readwrite, assign, nonatomic) FLZfPhotoSetType typeValue;
@end

