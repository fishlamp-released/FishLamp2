//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadAccessRealm.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfLoadAccessRealm
// --------------------------------------------------------------------
@interface FLZfLoadAccessRealm : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _realmId;
} 


@property (readwrite, retain, nonatomic) NSNumber* realmId;

+ (NSString*) realmIdKey;

+ (FLZfLoadAccessRealm*) loadAccessRealm; 

@end

@interface FLZfLoadAccessRealm (ValueProperties) 

@property (readwrite, assign, nonatomic) int realmIdValue;
@end

