//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadPrivateProfileResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfUser;

// --------------------------------------------------------------------
// FLZfLoadPrivateProfileResponse
// --------------------------------------------------------------------
@interface FLZfLoadPrivateProfileResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfUser* _LoadPrivateProfileResult;
} 


@property (readwrite, retain, nonatomic) FLZfUser* LoadPrivateProfileResult;

+ (NSString*) LoadPrivateProfileResultKey;

+ (FLZfLoadPrivateProfileResponse*) loadPrivateProfileResponse; 

@end

@interface FLZfLoadPrivateProfileResponse (ValueProperties) 
@end

