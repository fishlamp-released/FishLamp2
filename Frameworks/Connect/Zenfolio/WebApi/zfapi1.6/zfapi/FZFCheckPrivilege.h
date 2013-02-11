//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCheckPrivilege.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioCheckPrivilege
// --------------------------------------------------------------------
@interface FLZenfolioCheckPrivilege : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _loginName;
	NSString* _privilegeName;
} 


@property (readwrite, retain, nonatomic) NSString* loginName;

@property (readwrite, retain, nonatomic) NSString* privilegeName;

+ (NSString*) loginNameKey;

+ (NSString*) privilegeNameKey;

+ (FLZenfolioCheckPrivilege*) checkPrivilege; 

@end

@interface FLZenfolioCheckPrivilege (ValueProperties) 
@end

