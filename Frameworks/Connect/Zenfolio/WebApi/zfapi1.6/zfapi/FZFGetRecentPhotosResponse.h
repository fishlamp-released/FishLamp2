//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetRecentPhotosResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioPhoto;

// --------------------------------------------------------------------
// FLZenfolioGetRecentPhotosResponse
// --------------------------------------------------------------------
@interface FLZenfolioGetRecentPhotosResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _GetRecentPhotosResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* GetRecentPhotosResult;
// Type: FLZenfolioPhoto*, forKey: Photo

+ (NSString*) GetRecentPhotosResultKey;

+ (FLZenfolioGetRecentPhotosResponse*) getRecentPhotosResponse; 

@end

@interface FLZenfolioGetRecentPhotosResponse (ValueProperties) 
@end

