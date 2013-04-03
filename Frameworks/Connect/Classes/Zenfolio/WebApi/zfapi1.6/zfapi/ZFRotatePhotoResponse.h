//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFRotatePhotoResponse.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class ZFPhoto;

// --------------------------------------------------------------------
// ZFRotatePhotoResponse
// --------------------------------------------------------------------
@interface ZFRotatePhotoResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFPhoto* _RotatePhotoResult;
} 


@property (readwrite, retain, nonatomic) ZFPhoto* RotatePhotoResult;

+ (NSString*) RotatePhotoResultKey;

+ (ZFRotatePhotoResponse*) rotatePhotoResponse; 

@end

@interface ZFRotatePhotoResponse (ValueProperties) 
@end

