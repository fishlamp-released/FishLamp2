//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCreatePhotoSetResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfPhotoSet;

// --------------------------------------------------------------------
// FLZfCreatePhotoSetResponse
// --------------------------------------------------------------------
@interface FLZfCreatePhotoSetResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfPhotoSet* _CreatePhotoSetResult;
} 


@property (readwrite, retain, nonatomic) FLZfPhotoSet* CreatePhotoSetResult;

+ (NSString*) CreatePhotoSetResultKey;

+ (FLZfCreatePhotoSetResponse*) createPhotoSetResponse; 

@end

@interface FLZfCreatePhotoSetResponse (ValueProperties) 
@end

