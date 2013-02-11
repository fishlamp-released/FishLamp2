//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUpdatePhotoAccessResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioUpdatePhotoAccessResponse
// --------------------------------------------------------------------
@interface FLZenfolioUpdatePhotoAccessResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _UpdatePhotoAccessResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* UpdatePhotoAccessResult;

+ (NSString*) UpdatePhotoAccessResultKey;

+ (FLZenfolioUpdatePhotoAccessResponse*) updatePhotoAccessResponse; 

@end

@interface FLZenfolioUpdatePhotoAccessResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) int UpdatePhotoAccessResultValue;
@end

