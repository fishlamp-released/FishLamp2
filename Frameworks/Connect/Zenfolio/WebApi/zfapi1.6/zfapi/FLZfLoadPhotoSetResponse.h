//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadPhotoSetResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfPhotoSet;

// --------------------------------------------------------------------
// FLZfLoadPhotoSetResponse
// --------------------------------------------------------------------
@interface FLZfLoadPhotoSetResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfPhotoSet* _LoadPhotoSetResult;
} 


@property (readwrite, retain, nonatomic) FLZfPhotoSet* LoadPhotoSetResult;

+ (NSString*) LoadPhotoSetResultKey;

+ (FLZfLoadPhotoSetResponse*) loadPhotoSetResponse; 

@end

@interface FLZfLoadPhotoSetResponse (ValueProperties) 
@end

