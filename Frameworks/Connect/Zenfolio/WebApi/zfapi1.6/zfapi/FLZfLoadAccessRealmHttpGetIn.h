//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadAccessRealmHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfLoadAccessRealmHttpGetIn
// --------------------------------------------------------------------
@interface FLZfLoadAccessRealmHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _realmId;
} 


@property (readwrite, retain, nonatomic) NSString* realmId;

+ (NSString*) realmIdKey;

+ (FLZfLoadAccessRealmHttpGetIn*) loadAccessRealmHttpGetIn; 

@end

@interface FLZfLoadAccessRealmHttpGetIn (ValueProperties) 
@end

