//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadAccessRealmResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfAccessDescriptor;

// --------------------------------------------------------------------
// FLZfLoadAccessRealmResponse
// --------------------------------------------------------------------
@interface FLZfLoadAccessRealmResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZfAccessDescriptor* _LoadAccessRealmResult;
} 


@property (readwrite, retain, nonatomic) FLZfAccessDescriptor* LoadAccessRealmResult;

+ (NSString*) LoadAccessRealmResultKey;

+ (FLZfLoadAccessRealmResponse*) loadAccessRealmResponse; 

@end

@interface FLZfLoadAccessRealmResponse (ValueProperties) 
@end

