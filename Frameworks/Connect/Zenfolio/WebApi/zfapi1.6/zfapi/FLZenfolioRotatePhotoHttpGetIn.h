//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioRotatePhotoHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioRotatePhotoHttpGetIn
// --------------------------------------------------------------------
@interface FLZenfolioRotatePhotoHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoId;
	NSString* _rotation;
} 


@property (readwrite, retain, nonatomic) NSString* photoId;

@property (readwrite, retain, nonatomic) NSString* rotation;

+ (NSString*) photoIdKey;

+ (NSString*) rotationKey;

+ (FLZenfolioRotatePhotoHttpGetIn*) rotatePhotoHttpGetIn; 

@end

@interface FLZenfolioRotatePhotoHttpGetIn (ValueProperties) 
@end

