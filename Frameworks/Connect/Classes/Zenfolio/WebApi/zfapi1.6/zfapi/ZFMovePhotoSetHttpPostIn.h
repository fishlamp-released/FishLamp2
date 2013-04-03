//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFMovePhotoSetHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFMovePhotoSetHttpPostIn
// --------------------------------------------------------------------
@interface ZFMovePhotoSetHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
	NSString* _destGroupId;
	NSString* _index;
} 


@property (readwrite, retain, nonatomic) NSString* destGroupId;

@property (readwrite, retain, nonatomic) NSString* index;

@property (readwrite, retain, nonatomic) NSString* photoSetId;

+ (NSString*) destGroupIdKey;

+ (NSString*) indexKey;

+ (NSString*) photoSetIdKey;

+ (ZFMovePhotoSetHttpPostIn*) movePhotoSetHttpPostIn; 

@end

@interface ZFMovePhotoSetHttpPostIn (ValueProperties) 
@end

