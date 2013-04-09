//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFMovePhoto.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFMovePhoto
// --------------------------------------------------------------------
@interface ZFMovePhoto : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _srcSetId;
	NSNumber* _photoId;
	NSNumber* _destSetId;
	NSNumber* _index;
} 


@property (readwrite, retain, nonatomic) NSNumber* destSetId;

@property (readwrite, retain, nonatomic) NSNumber* index;

@property (readwrite, retain, nonatomic) NSNumber* photoId;

@property (readwrite, retain, nonatomic) NSNumber* srcSetId;

+ (NSString*) destSetIdKey;

+ (NSString*) indexKey;

+ (NSString*) photoIdKey;

+ (NSString*) srcSetIdKey;

+ (ZFMovePhoto*) movePhoto; 

@end

@interface ZFMovePhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int srcSetIdValue;

@property (readwrite, assign, nonatomic) int photoIdValue;

@property (readwrite, assign, nonatomic) int destSetIdValue;

@property (readwrite, assign, nonatomic) int indexValue;
@end
