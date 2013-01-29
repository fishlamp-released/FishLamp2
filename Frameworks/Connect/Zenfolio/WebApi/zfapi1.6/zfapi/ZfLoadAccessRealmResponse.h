//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadAccessRealmResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFAccessDescriptor;

// --------------------------------------------------------------------
// ZFLoadAccessRealmResponse
// --------------------------------------------------------------------
@interface ZFLoadAccessRealmResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFAccessDescriptor* _LoadAccessRealmResult;
} 


@property (readwrite, retain, nonatomic) ZFAccessDescriptor* LoadAccessRealmResult;

+ (NSString*) LoadAccessRealmResultKey;

+ (ZFLoadAccessRealmResponse*) loadAccessRealmResponse; 

@end

@interface ZFLoadAccessRealmResponse (ValueProperties) 
@end

