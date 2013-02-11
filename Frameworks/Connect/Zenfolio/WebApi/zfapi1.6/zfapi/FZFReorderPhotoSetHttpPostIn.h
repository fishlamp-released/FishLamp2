//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioReorderPhotoSetHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioReorderPhotoSetHttpPostIn
// --------------------------------------------------------------------
@interface FLZenfolioReorderPhotoSetHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
	NSString* _shiftOrder;
} 


@property (readwrite, retain, nonatomic) NSString* photoSetId;

@property (readwrite, retain, nonatomic) NSString* shiftOrder;

+ (NSString*) photoSetIdKey;

+ (NSString*) shiftOrderKey;

+ (FLZenfolioReorderPhotoSetHttpPostIn*) reorderPhotoSetHttpPostIn; 

@end

@interface FLZenfolioReorderPhotoSetHttpPostIn (ValueProperties) 
@end

