//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadPublicProfileResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfUser;

// --------------------------------------------------------------------
// FLZfLoadPublicProfileResponse
// --------------------------------------------------------------------
@interface FLZfLoadPublicProfileResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfUser* _LoadPublicProfileResult;
} 


@property (readwrite, retain, nonatomic) FLZfUser* LoadPublicProfileResult;

+ (NSString*) LoadPublicProfileResultKey;

+ (FLZfLoadPublicProfileResponse*) loadPublicProfileResponse; 

@end

@interface FLZfLoadPublicProfileResponse (ValueProperties) 
@end

