//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfDeletePhotoSetHttpPostIn.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfDeletePhotoSetHttpPostIn
// --------------------------------------------------------------------
@interface FLZfDeletePhotoSetHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
} 


@property (readwrite, retain, nonatomic) NSString* photoSetId;

+ (NSString*) photoSetIdKey;

+ (FLZfDeletePhotoSetHttpPostIn*) deletePhotoSetHttpPostIn; 

@end

@interface FLZfDeletePhotoSetHttpPostIn (ValueProperties) 
@end

