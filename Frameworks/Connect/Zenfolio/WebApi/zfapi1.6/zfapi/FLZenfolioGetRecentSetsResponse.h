//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetRecentSetsResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioPhotoSet;

// --------------------------------------------------------------------
// FLZenfolioGetRecentSetsResponse
// --------------------------------------------------------------------
@interface FLZenfolioGetRecentSetsResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _GetRecentSetsResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* GetRecentSetsResult;
// Type: FLZenfolioPhotoSet*, forKey: PhotoSet

+ (NSString*) GetRecentSetsResultKey;

+ (FLZenfolioGetRecentSetsResponse*) getRecentSetsResponse; 

@end

@interface FLZenfolioGetRecentSetsResponse (ValueProperties) 
@end

