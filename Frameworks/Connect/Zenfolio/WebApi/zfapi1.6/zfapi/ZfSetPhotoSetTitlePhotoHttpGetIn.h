//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSetPhotoSetTitlePhotoHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFSetPhotoSetTitlePhotoHttpGetIn
// --------------------------------------------------------------------
@interface ZFSetPhotoSetTitlePhotoHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
	NSString* _photoId;
} 


@property (readwrite, retain, nonatomic) NSString* photoId;

@property (readwrite, retain, nonatomic) NSString* photoSetId;

+ (NSString*) photoIdKey;

+ (NSString*) photoSetIdKey;

+ (ZFSetPhotoSetTitlePhotoHttpGetIn*) setPhotoSetTitlePhotoHttpGetIn; 

@end

@interface ZFSetPhotoSetTitlePhotoHttpGetIn (ValueProperties) 
@end

