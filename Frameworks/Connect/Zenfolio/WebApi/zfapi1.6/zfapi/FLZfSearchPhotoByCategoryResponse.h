//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfSearchPhotoByCategoryResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfPhotoResult;

// --------------------------------------------------------------------
// FLZfSearchPhotoByCategoryResponse
// --------------------------------------------------------------------
@interface FLZfSearchPhotoByCategoryResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfPhotoResult* _SearchPhotoByCategoryResult;
} 


@property (readwrite, retain, nonatomic) FLZfPhotoResult* SearchPhotoByCategoryResult;

+ (NSString*) SearchPhotoByCategoryResultKey;

+ (FLZfSearchPhotoByCategoryResponse*) searchPhotoByCategoryResponse; 

@end

@interface FLZfSearchPhotoByCategoryResponse (ValueProperties) 
@end

