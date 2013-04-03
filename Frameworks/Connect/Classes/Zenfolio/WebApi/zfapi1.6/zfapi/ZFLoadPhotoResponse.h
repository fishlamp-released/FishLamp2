//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPhotoResponse.h
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
// ZFLoadPhotoResponse
// --------------------------------------------------------------------
@interface ZFLoadPhotoResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFPhoto* _LoadPhotoResult;
} 


@property (readwrite, retain, nonatomic) ZFPhoto* LoadPhotoResult;

+ (NSString*) LoadPhotoResultKey;

+ (ZFLoadPhotoResponse*) loadPhotoResponse; 

@end

@interface ZFLoadPhotoResponse (ValueProperties) 
@end

