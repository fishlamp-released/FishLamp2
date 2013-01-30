//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCheckPrivilegeResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioCheckPrivilegeResponse
// --------------------------------------------------------------------
@interface FLZenfolioCheckPrivilegeResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _CheckPrivilegeResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* CheckPrivilegeResult;

+ (NSString*) CheckPrivilegeResultKey;

+ (FLZenfolioCheckPrivilegeResponse*) checkPrivilegeResponse; 

@end

@interface FLZenfolioCheckPrivilegeResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL CheckPrivilegeResultValue;
@end

