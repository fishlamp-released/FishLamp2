//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfSetGroupTitlePhotoHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfSetGroupTitlePhotoHttpGetIn
// --------------------------------------------------------------------
@interface FLZfSetGroupTitlePhotoHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _groupId;
	NSString* _photoId;
} 


@property (readwrite, retain, nonatomic) NSString* groupId;

@property (readwrite, retain, nonatomic) NSString* photoId;

+ (NSString*) groupIdKey;

+ (NSString*) photoIdKey;

+ (FLZfSetGroupTitlePhotoHttpGetIn*) setGroupTitlePhotoHttpGetIn; 

@end

@interface FLZfSetGroupTitlePhotoHttpGetIn (ValueProperties) 
@end

