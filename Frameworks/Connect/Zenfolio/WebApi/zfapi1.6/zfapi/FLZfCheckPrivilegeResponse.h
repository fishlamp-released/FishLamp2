//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCheckPrivilegeResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfCheckPrivilegeResponse
// --------------------------------------------------------------------
@interface FLZfCheckPrivilegeResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _CheckPrivilegeResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* CheckPrivilegeResult;

+ (NSString*) CheckPrivilegeResultKey;

+ (FLZfCheckPrivilegeResponse*) checkPrivilegeResponse; 

@end

@interface FLZfCheckPrivilegeResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL CheckPrivilegeResultValue;
@end

