//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioReplacePhotoHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioReplacePhotoHttpPostIn
// --------------------------------------------------------------------
@interface FLZenfolioReplacePhotoHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _originalId;
	NSString* _replacedId;
} 


@property (readwrite, retain, nonatomic) NSString* originalId;

@property (readwrite, retain, nonatomic) NSString* replacedId;

+ (NSString*) originalIdKey;

+ (NSString*) replacedIdKey;

+ (FLZenfolioReplacePhotoHttpPostIn*) replacePhotoHttpPostIn; 

@end

@interface FLZenfolioReplacePhotoHttpPostIn (ValueProperties) 
@end

