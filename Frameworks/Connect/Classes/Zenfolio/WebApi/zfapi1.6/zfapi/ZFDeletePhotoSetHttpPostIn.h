//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFDeletePhotoSetHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFDeletePhotoSetHttpPostIn
// --------------------------------------------------------------------
@interface ZFDeletePhotoSetHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
} 


@property (readwrite, retain, nonatomic) NSString* photoSetId;

+ (NSString*) photoSetIdKey;

+ (ZFDeletePhotoSetHttpPostIn*) deletePhotoSetHttpPostIn; 

@end

@interface ZFDeletePhotoSetHttpPostIn (ValueProperties) 
@end

