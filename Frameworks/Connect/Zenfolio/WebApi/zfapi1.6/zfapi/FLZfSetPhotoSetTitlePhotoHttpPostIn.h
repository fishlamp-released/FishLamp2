//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfSetPhotoSetTitlePhotoHttpPostIn.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfSetPhotoSetTitlePhotoHttpPostIn
// --------------------------------------------------------------------
@interface FLZfSetPhotoSetTitlePhotoHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
	NSString* _photoId;
} 


@property (readwrite, retain, nonatomic) NSString* photoId;

@property (readwrite, retain, nonatomic) NSString* photoSetId;

+ (NSString*) photoIdKey;

+ (NSString*) photoSetIdKey;

+ (FLZfSetPhotoSetTitlePhotoHttpPostIn*) setPhotoSetTitlePhotoHttpPostIn; 

@end

@interface FLZfSetPhotoSetTitlePhotoHttpPostIn (ValueProperties) 
@end

