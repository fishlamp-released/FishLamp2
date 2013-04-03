//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFMovePhotoHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFMovePhotoHttpPostIn
// --------------------------------------------------------------------
@interface ZFMovePhotoHttpPostIn : NSObject<NSCoding, NSCopying>{ 
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

+ (ZFMovePhotoHttpPostIn*) movePhotoHttpPostIn; 

@end

@interface ZFMovePhotoHttpPostIn (ValueProperties) 
@end

