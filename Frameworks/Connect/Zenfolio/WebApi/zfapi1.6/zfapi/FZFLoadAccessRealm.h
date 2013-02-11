//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadAccessRealm.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioLoadAccessRealm
// --------------------------------------------------------------------
@interface FLZenfolioLoadAccessRealm : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _realmId;
} 


@property (readwrite, retain, nonatomic) NSNumber* realmId;

+ (NSString*) realmIdKey;

+ (FLZenfolioLoadAccessRealm*) loadAccessRealm; 

@end

@interface FLZenfolioLoadAccessRealm (ValueProperties) 

@property (readwrite, assign, nonatomic) int realmIdValue;
@end

