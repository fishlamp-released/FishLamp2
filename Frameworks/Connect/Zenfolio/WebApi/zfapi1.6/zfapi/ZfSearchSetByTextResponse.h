//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSearchSetByTextResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFPhotoSetResult;

// --------------------------------------------------------------------
// ZFSearchSetByTextResponse
// --------------------------------------------------------------------
@interface ZFSearchSetByTextResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFPhotoSetResult* _SearchSetByTextResult;
} 


@property (readwrite, retain, nonatomic) ZFPhotoSetResult* SearchSetByTextResult;

+ (NSString*) SearchSetByTextResultKey;

+ (ZFSearchSetByTextResponse*) searchSetByTextResponse; 

@end

@interface ZFSearchSetByTextResponse (ValueProperties) 
@end

