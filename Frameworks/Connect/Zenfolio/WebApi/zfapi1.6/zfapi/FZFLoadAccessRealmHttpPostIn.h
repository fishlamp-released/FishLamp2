//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadAccessRealmHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioLoadAccessRealmHttpPostIn
// --------------------------------------------------------------------
@interface FLZenfolioLoadAccessRealmHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _realmId;
} 


@property (readwrite, retain, nonatomic) NSString* realmId;

+ (NSString*) realmIdKey;

+ (FLZenfolioLoadAccessRealmHttpPostIn*) loadAccessRealmHttpPostIn; 

@end

@interface FLZenfolioLoadAccessRealmHttpPostIn (ValueProperties) 
@end

