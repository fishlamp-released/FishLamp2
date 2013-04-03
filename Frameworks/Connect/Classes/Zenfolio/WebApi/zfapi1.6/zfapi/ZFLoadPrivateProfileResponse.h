//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPrivateProfileResponse.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class ZFUser;

// --------------------------------------------------------------------
// ZFLoadPrivateProfileResponse
// --------------------------------------------------------------------
@interface ZFLoadPrivateProfileResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFUser* _LoadPrivateProfileResult;
} 


@property (readwrite, retain, nonatomic) ZFUser* LoadPrivateProfileResult;

+ (NSString*) LoadPrivateProfileResultKey;

+ (ZFLoadPrivateProfileResponse*) loadPrivateProfileResponse; 

@end

@interface ZFLoadPrivateProfileResponse (ValueProperties) 
@end

