//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetPopularPhotosResponse.h
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
// ZFGetPopularPhotosResponse
// --------------------------------------------------------------------
@interface ZFGetPopularPhotosResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _GetPopularPhotosResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* GetPopularPhotosResult;
// Type: ZFPhoto*, forKey: Photo

+ (NSString*) GetPopularPhotosResultKey;

+ (ZFGetPopularPhotosResponse*) getPopularPhotosResponse; 

@end

@interface ZFGetPopularPhotosResponse (ValueProperties) 
@end

