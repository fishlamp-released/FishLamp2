//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFRotatePhoto.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


#import "ZFApi1_6Enums.h"

// --------------------------------------------------------------------
// ZFRotatePhoto
// --------------------------------------------------------------------
@interface ZFRotatePhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoId;
	NSString* _rotation;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoId;

@property (readwrite, retain, nonatomic) NSString* rotation;

+ (NSString*) photoIdKey;

+ (NSString*) rotationKey;

+ (ZFRotatePhoto*) rotatePhoto; 

@end

@interface ZFRotatePhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoIdValue;

@property (readwrite, assign, nonatomic) ZFPhotoRotation rotationValue;
@end

