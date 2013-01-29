//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdatePhotoResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFPhoto;

// --------------------------------------------------------------------
// ZFUpdatePhotoResponse
// --------------------------------------------------------------------
@interface ZFUpdatePhotoResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFPhoto* _UpdatePhotoResult;
} 


@property (readwrite, retain, nonatomic) ZFPhoto* UpdatePhotoResult;

+ (NSString*) UpdatePhotoResultKey;

+ (ZFUpdatePhotoResponse*) updatePhotoResponse; 

@end

@interface ZFUpdatePhotoResponse (ValueProperties) 
@end

