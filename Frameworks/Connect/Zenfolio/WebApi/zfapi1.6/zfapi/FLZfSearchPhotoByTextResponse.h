//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfSearchPhotoByTextResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfPhotoResult;

// --------------------------------------------------------------------
// FLZfSearchPhotoByTextResponse
// --------------------------------------------------------------------
@interface FLZfSearchPhotoByTextResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfPhotoResult* _SearchPhotoByTextResult;
} 


@property (readwrite, retain, nonatomic) FLZfPhotoResult* SearchPhotoByTextResult;

+ (NSString*) SearchPhotoByTextResultKey;

+ (FLZfSearchPhotoByTextResponse*) searchPhotoByTextResponse; 

@end

@interface FLZfSearchPhotoByTextResponse (ValueProperties) 
@end

