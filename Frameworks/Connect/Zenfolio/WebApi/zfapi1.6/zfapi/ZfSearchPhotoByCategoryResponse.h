//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSearchPhotoByCategoryResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFPhotoResult;

// --------------------------------------------------------------------
// ZFSearchPhotoByCategoryResponse
// --------------------------------------------------------------------
@interface ZFSearchPhotoByCategoryResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFPhotoResult* _SearchPhotoByCategoryResult;
} 


@property (readwrite, retain, nonatomic) ZFPhotoResult* SearchPhotoByCategoryResult;

+ (NSString*) SearchPhotoByCategoryResultKey;

+ (ZFSearchPhotoByCategoryResponse*) searchPhotoByCategoryResponse; 

@end

@interface ZFSearchPhotoByCategoryResponse (ValueProperties) 
@end

