//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadPhotoResponse.h
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
// FLZfLoadPhotoResponse
// --------------------------------------------------------------------
@interface FLZfLoadPhotoResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfPhoto* _LoadPhotoResult;
} 


@property (readwrite, retain, nonatomic) FLZfPhoto* LoadPhotoResult;

+ (NSString*) LoadPhotoResultKey;

+ (FLZfLoadPhotoResponse*) loadPhotoResponse; 

@end

@interface FLZfLoadPhotoResponse (ValueProperties) 
@end

