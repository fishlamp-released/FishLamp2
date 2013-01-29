//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfSearchSetByTextResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfPhotoSetResult;

// --------------------------------------------------------------------
// FLZfSearchSetByTextResponse
// --------------------------------------------------------------------
@interface FLZfSearchSetByTextResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfPhotoSetResult* _SearchSetByTextResult;
} 


@property (readwrite, retain, nonatomic) FLZfPhotoSetResult* SearchSetByTextResult;

+ (NSString*) SearchSetByTextResultKey;

+ (FLZfSearchSetByTextResponse*) searchSetByTextResponse; 

@end

@interface FLZfSearchSetByTextResponse (ValueProperties) 
@end

