//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioMovePhotoSetHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioMovePhotoSetHttpPostIn
// --------------------------------------------------------------------
@interface FLZenfolioMovePhotoSetHttpPostIn : NSObject<NSCoding, NSCopying>{ 
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

+ (FLZenfolioMovePhotoSetHttpPostIn*) movePhotoSetHttpPostIn; 

@end

@interface FLZenfolioMovePhotoSetHttpPostIn (ValueProperties) 
@end

