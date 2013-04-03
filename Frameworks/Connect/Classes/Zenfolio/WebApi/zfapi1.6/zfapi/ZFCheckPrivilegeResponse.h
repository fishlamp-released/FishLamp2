//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCheckPrivilegeResponse.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFCheckPrivilegeResponse
// --------------------------------------------------------------------
@interface ZFCheckPrivilegeResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _CheckPrivilegeResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* CheckPrivilegeResult;

+ (NSString*) CheckPrivilegeResultKey;

+ (ZFCheckPrivilegeResponse*) checkPrivilegeResponse; 

@end

@interface ZFCheckPrivilegeResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL CheckPrivilegeResultValue;
@end

