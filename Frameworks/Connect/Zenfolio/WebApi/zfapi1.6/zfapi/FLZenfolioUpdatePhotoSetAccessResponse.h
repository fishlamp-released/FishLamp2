//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUpdatePhotoSetAccessResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioUpdatePhotoSetAccessResponse
// --------------------------------------------------------------------
@interface FLZenfolioUpdatePhotoSetAccessResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _UpdatePhotoSetAccessResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* UpdatePhotoSetAccessResult;

+ (NSString*) UpdatePhotoSetAccessResultKey;

+ (FLZenfolioUpdatePhotoSetAccessResponse*) updatePhotoSetAccessResponse; 

@end

@interface FLZenfolioUpdatePhotoSetAccessResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) int UpdatePhotoSetAccessResultValue;
@end

