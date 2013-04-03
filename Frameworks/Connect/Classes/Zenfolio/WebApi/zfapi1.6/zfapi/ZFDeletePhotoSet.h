//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFDeletePhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFDeletePhotoSet
// --------------------------------------------------------------------
@interface ZFDeletePhotoSet : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

+ (NSString*) photoSetIdKey;

+ (ZFDeletePhotoSet*) deletePhotoSet; 

@end

@interface ZFDeletePhotoSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;
@end

