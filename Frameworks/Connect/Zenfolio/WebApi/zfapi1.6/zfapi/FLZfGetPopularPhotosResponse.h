//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfGetPopularPhotosResponse.h
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
// FLZfGetPopularPhotosResponse
// --------------------------------------------------------------------
@interface FLZfGetPopularPhotosResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _GetPopularPhotosResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* GetPopularPhotosResult;
// Type: FLZfPhoto*, forKey: Photo

+ (NSString*) GetPopularPhotosResultKey;

+ (FLZfGetPopularPhotosResponse*) getPopularPhotosResponse; 

@end

@interface FLZfGetPopularPhotosResponse (ValueProperties) 
@end

