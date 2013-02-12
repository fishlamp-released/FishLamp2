//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadPhotoHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioLoadPhotoHttpPostIn
// --------------------------------------------------------------------
@interface FLZenfolioLoadPhotoHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoId;
	NSString* _level;
} 


@property (readwrite, retain, nonatomic) NSString* level;

@property (readwrite, retain, nonatomic) NSString* photoId;

+ (NSString*) levelKey;

+ (NSString*) photoIdKey;

+ (FLZenfolioLoadPhotoHttpPostIn*) loadPhotoHttpPostIn; 

@end

@interface FLZenfolioLoadPhotoHttpPostIn (ValueProperties) 
@end

