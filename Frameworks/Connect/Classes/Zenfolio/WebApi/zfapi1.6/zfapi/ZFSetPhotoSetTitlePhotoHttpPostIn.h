//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSetPhotoSetTitlePhotoHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFSetPhotoSetTitlePhotoHttpPostIn
// --------------------------------------------------------------------
@interface ZFSetPhotoSetTitlePhotoHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
	NSString* _photoId;
} 


@property (readwrite, retain, nonatomic) NSString* photoId;

@property (readwrite, retain, nonatomic) NSString* photoSetId;

+ (NSString*) photoIdKey;

+ (NSString*) photoSetIdKey;

+ (ZFSetPhotoSetTitlePhotoHttpPostIn*) setPhotoSetTitlePhotoHttpPostIn; 

@end

@interface ZFSetPhotoSetTitlePhotoHttpPostIn (ValueProperties) 
@end

