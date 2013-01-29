//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSetGroupTitlePhotoHttpPostIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFSetGroupTitlePhotoHttpPostIn
// --------------------------------------------------------------------
@interface ZFSetGroupTitlePhotoHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _groupId;
	NSString* _photoId;
} 


@property (readwrite, retain, nonatomic) NSString* groupId;

@property (readwrite, retain, nonatomic) NSString* photoId;

+ (NSString*) groupIdKey;

+ (NSString*) photoIdKey;

+ (ZFSetGroupTitlePhotoHttpPostIn*) setGroupTitlePhotoHttpPostIn; 

@end

@interface ZFSetGroupTitlePhotoHttpPostIn (ValueProperties) 
@end

