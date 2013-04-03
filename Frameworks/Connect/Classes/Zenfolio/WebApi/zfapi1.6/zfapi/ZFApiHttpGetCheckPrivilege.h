//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetCheckPrivilege.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Checks if the the specified user is granted a privilege. <A href="/Zenfolio/help/api/ref/methods/checkprivilege">More...</A>
*/



@class ZFCheckPrivilegeHttpGetIn;

// --------------------------------------------------------------------
// ZFApiHttpGetCheckPrivilege
// --------------------------------------------------------------------
@interface ZFApiHttpGetCheckPrivilege : NSObject{ 
@private
	ZFCheckPrivilegeHttpGetIn* _input;
	NSNumber* _output;
} 


@property (readwrite, retain, nonatomic) ZFCheckPrivilegeHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSNumber* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetCheckPrivilege*) apiHttpGetCheckPrivilege; 

@end

@interface ZFApiHttpGetCheckPrivilege (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL outputValue;
@end


@interface ZFApiHttpGetCheckPrivilege (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFCheckPrivilegeHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

