//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfRotatePhotoResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfPhoto;

// --------------------------------------------------------------------
// FLZfRotatePhotoResponse
// --------------------------------------------------------------------
@interface FLZfRotatePhotoResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfPhoto* _RotatePhotoResult;
} 


@property (readwrite, retain, nonatomic) FLZfPhoto* RotatePhotoResult;

+ (NSString*) RotatePhotoResultKey;

+ (FLZfRotatePhotoResponse*) rotatePhotoResponse; 

@end

@interface FLZfRotatePhotoResponse (ValueProperties) 
@end

