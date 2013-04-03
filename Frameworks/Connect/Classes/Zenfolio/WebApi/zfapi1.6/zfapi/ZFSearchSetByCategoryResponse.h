//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSearchSetByCategoryResponse.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class ZFPhotoSetResult;

// --------------------------------------------------------------------
// ZFSearchSetByCategoryResponse
// --------------------------------------------------------------------
@interface ZFSearchSetByCategoryResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFPhotoSetResult* _SearchSetByCategoryResult;
} 


@property (readwrite, retain, nonatomic) ZFPhotoSetResult* SearchSetByCategoryResult;

+ (NSString*) SearchSetByCategoryResultKey;

+ (ZFSearchSetByCategoryResponse*) searchSetByCategoryResponse; 

@end

@interface ZFSearchSetByCategoryResponse (ValueProperties) 
@end

