//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadAccessRealm.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFLoadAccessRealm
// --------------------------------------------------------------------
@interface ZFLoadAccessRealm : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _realmId;
} 


@property (readwrite, retain, nonatomic) NSNumber* realmId;

+ (NSString*) realmIdKey;

+ (ZFLoadAccessRealm*) loadAccessRealm; 

@end

@interface ZFLoadAccessRealm (ValueProperties) 

@property (readwrite, assign, nonatomic) int realmIdValue;
@end

