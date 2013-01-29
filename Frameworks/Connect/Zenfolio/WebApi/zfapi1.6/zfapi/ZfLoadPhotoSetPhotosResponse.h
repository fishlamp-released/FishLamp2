//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPhotoSetPhotosResponse.h
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
// ZFLoadPhotoSetPhotosResponse
// --------------------------------------------------------------------
@interface ZFLoadPhotoSetPhotosResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _LoadPhotoSetPhotosResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* LoadPhotoSetPhotosResult;
// Type: ZFPhoto*, forKey: Photo

+ (NSString*) LoadPhotoSetPhotosResultKey;

+ (ZFLoadPhotoSetPhotosResponse*) loadPhotoSetPhotosResponse; 

@end

@interface ZFLoadPhotoSetPhotosResponse (ValueProperties) 
@end

