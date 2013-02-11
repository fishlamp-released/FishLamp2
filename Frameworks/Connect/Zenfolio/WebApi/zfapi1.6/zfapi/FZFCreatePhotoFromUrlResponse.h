//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCreatePhotoFromUrlResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioCreatePhotoFromUrlResponse
// --------------------------------------------------------------------
@interface FLZenfolioCreatePhotoFromUrlResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _CreatePhotoFromUrlResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* CreatePhotoFromUrlResult;

+ (NSString*) CreatePhotoFromUrlResultKey;

+ (FLZenfolioCreatePhotoFromUrlResponse*) createPhotoFromUrlResponse; 

@end

@interface FLZenfolioCreatePhotoFromUrlResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) int CreatePhotoFromUrlResultValue;
@end

