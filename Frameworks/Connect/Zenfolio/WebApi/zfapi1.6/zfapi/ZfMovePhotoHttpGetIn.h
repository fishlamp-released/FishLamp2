//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFMovePhotoHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFMovePhotoHttpGetIn
// --------------------------------------------------------------------
@interface ZFMovePhotoHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _srcSetId;
	NSString* _photoId;
	NSString* _destSetId;
	NSString* _index;
} 


@property (readwrite, retain, nonatomic) NSString* destSetId;

@property (readwrite, retain, nonatomic) NSString* index;

@property (readwrite, retain, nonatomic) NSString* photoId;

@property (readwrite, retain, nonatomic) NSString* srcSetId;

+ (NSString*) destSetIdKey;

+ (NSString*) indexKey;

+ (NSString*) photoIdKey;

+ (NSString*) srcSetIdKey;

+ (ZFMovePhotoHttpGetIn*) movePhotoHttpGetIn; 

@end

@interface ZFMovePhotoHttpGetIn (ValueProperties) 
@end

