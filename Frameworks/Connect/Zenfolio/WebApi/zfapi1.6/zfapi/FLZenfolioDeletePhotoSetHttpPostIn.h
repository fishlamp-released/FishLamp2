//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioDeletePhotoSetHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioDeletePhotoSetHttpPostIn
// --------------------------------------------------------------------
@interface FLZenfolioDeletePhotoSetHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
} 


@property (readwrite, retain, nonatomic) NSString* photoSetId;

+ (NSString*) photoSetIdKey;

+ (FLZenfolioDeletePhotoSetHttpPostIn*) deletePhotoSetHttpPostIn; 

@end

@interface FLZenfolioDeletePhotoSetHttpPostIn (ValueProperties) 
@end

