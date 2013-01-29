//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfUpdatePhotoSetResponse.h
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
// FLZfUpdatePhotoSetResponse
// --------------------------------------------------------------------
@interface FLZfUpdatePhotoSetResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfPhotoSet* _UpdatePhotoSetResult;
} 


@property (readwrite, retain, nonatomic) FLZfPhotoSet* UpdatePhotoSetResult;

+ (NSString*) UpdatePhotoSetResultKey;

+ (FLZfUpdatePhotoSetResponse*) updatePhotoSetResponse; 

@end

@interface FLZfUpdatePhotoSetResponse (ValueProperties) 
@end

