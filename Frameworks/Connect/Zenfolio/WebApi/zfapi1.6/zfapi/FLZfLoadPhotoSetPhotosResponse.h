//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadPhotoSetPhotosResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfPhoto;

// --------------------------------------------------------------------
// FLZfLoadPhotoSetPhotosResponse
// --------------------------------------------------------------------
@interface FLZfLoadPhotoSetPhotosResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _LoadPhotoSetPhotosResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* LoadPhotoSetPhotosResult;
// Type: FLZfPhoto*, forKey: Photo

+ (NSString*) LoadPhotoSetPhotosResultKey;

+ (FLZfLoadPhotoSetPhotosResponse*) loadPhotoSetPhotosResponse; 

@end

@interface FLZfLoadPhotoSetPhotosResponse (ValueProperties) 
@end

