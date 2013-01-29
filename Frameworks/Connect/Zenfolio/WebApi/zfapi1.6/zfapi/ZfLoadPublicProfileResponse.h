//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPublicProfileResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFUser;

// --------------------------------------------------------------------
// ZFLoadPublicProfileResponse
// --------------------------------------------------------------------
@interface ZFLoadPublicProfileResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFUser* _LoadPublicProfileResult;
} 


@property (readwrite, retain, nonatomic) ZFUser* LoadPublicProfileResult;

+ (NSString*) LoadPublicProfileResultKey;

+ (ZFLoadPublicProfileResponse*) loadPublicProfileResponse; 

@end

@interface ZFLoadPublicProfileResponse (ValueProperties) 
@end

