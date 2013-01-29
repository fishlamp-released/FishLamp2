//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFRotatePhotoHttpPostIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFRotatePhotoHttpPostIn
// --------------------------------------------------------------------
@interface ZFRotatePhotoHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoId;
	NSString* _rotation;
} 


@property (readwrite, retain, nonatomic) NSString* photoId;

@property (readwrite, retain, nonatomic) NSString* rotation;

+ (NSString*) photoIdKey;

+ (NSString*) rotationKey;

+ (ZFRotatePhotoHttpPostIn*) rotatePhotoHttpPostIn; 

@end

@interface ZFRotatePhotoHttpPostIn (ValueProperties) 
@end

