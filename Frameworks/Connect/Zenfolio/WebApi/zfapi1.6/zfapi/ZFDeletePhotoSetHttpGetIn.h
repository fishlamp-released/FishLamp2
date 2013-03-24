//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFDeletePhotoSetHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFDeletePhotoSetHttpGetIn
// --------------------------------------------------------------------
@interface ZFDeletePhotoSetHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
} 


@property (readwrite, retain, nonatomic) NSString* photoSetId;

+ (NSString*) photoSetIdKey;

+ (ZFDeletePhotoSetHttpGetIn*) deletePhotoSetHttpGetIn; 

@end

@interface ZFDeletePhotoSetHttpGetIn (ValueProperties) 
@end

