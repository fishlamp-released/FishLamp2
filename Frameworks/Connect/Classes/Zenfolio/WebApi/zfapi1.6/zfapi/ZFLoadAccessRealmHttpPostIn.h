//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadAccessRealmHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFLoadAccessRealmHttpPostIn
// --------------------------------------------------------------------
@interface ZFLoadAccessRealmHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _realmId;
} 


@property (readwrite, retain, nonatomic) NSString* realmId;

+ (NSString*) realmIdKey;

+ (ZFLoadAccessRealmHttpPostIn*) loadAccessRealmHttpPostIn; 

@end

@interface ZFLoadAccessRealmHttpPostIn (ValueProperties) 
@end

