//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCheckPrivilegeHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioCheckPrivilegeHttpGetIn
// --------------------------------------------------------------------
@interface FLZenfolioCheckPrivilegeHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _loginName;
	NSString* _privilegeName;
} 


@property (readwrite, retain, nonatomic) NSString* loginName;

@property (readwrite, retain, nonatomic) NSString* privilegeName;

+ (NSString*) loginNameKey;

+ (NSString*) privilegeNameKey;

+ (FLZenfolioCheckPrivilegeHttpGetIn*) checkPrivilegeHttpGetIn; 

@end

@interface FLZenfolioCheckPrivilegeHttpGetIn (ValueProperties) 
@end

