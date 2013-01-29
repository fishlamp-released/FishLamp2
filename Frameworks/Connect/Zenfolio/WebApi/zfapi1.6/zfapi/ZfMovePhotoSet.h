//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFMovePhotoSet.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFMovePhotoSet
// --------------------------------------------------------------------
@interface ZFMovePhotoSet : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
	NSNumber* _destGroupId;
	NSNumber* _index;
} 


@property (readwrite, retain, nonatomic) NSNumber* destGroupId;

@property (readwrite, retain, nonatomic) NSNumber* index;

@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

+ (NSString*) destGroupIdKey;

+ (NSString*) indexKey;

+ (NSString*) photoSetIdKey;

+ (ZFMovePhotoSet*) movePhotoSet; 

@end

@interface ZFMovePhotoSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;

@property (readwrite, assign, nonatomic) int destGroupIdValue;

@property (readwrite, assign, nonatomic) int indexValue;
@end

