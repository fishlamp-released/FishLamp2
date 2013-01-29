//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfDeletePhotoHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfDeletePhotoHttpPostIn
// --------------------------------------------------------------------
@interface FLZfDeletePhotoHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoId;
} 


@property (readwrite, retain, nonatomic) NSString* photoId;

+ (NSString*) photoIdKey;

+ (FLZfDeletePhotoHttpPostIn*) deletePhotoHttpPostIn; 

@end

@interface FLZfDeletePhotoHttpPostIn (ValueProperties) 
@end

