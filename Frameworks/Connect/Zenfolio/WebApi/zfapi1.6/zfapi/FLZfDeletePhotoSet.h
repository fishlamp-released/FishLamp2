//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfDeletePhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfDeletePhotoSet
// --------------------------------------------------------------------
@interface FLZfDeletePhotoSet : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

+ (NSString*) photoSetIdKey;

+ (FLZfDeletePhotoSet*) deletePhotoSet; 

@end

@interface FLZfDeletePhotoSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;
@end

