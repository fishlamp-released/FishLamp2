//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfUpdatePhotoResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfPhoto;

// --------------------------------------------------------------------
// FLZfUpdatePhotoResponse
// --------------------------------------------------------------------
@interface FLZfUpdatePhotoResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfPhoto* _UpdatePhotoResult;
} 


@property (readwrite, retain, nonatomic) FLZfPhoto* UpdatePhotoResult;

+ (NSString*) UpdatePhotoResultKey;

+ (FLZfUpdatePhotoResponse*) updatePhotoResponse; 

@end

@interface FLZfUpdatePhotoResponse (ValueProperties) 
@end

