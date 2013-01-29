//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapCheckPrivilege.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Checks if the the specified user is granted a privilege. <A href="/zf/help/api/ref/methods/checkprivilege">More...</A>
*/



@class ZFCheckPrivilege;
@class ZFCheckPrivilegeResponse;

// --------------------------------------------------------------------
// ZFApiSoapCheckPrivilege
// --------------------------------------------------------------------
@interface ZFApiSoapCheckPrivilege : NSObject{ 
@private
	ZFCheckPrivilege* _input;
	ZFCheckPrivilegeResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFCheckPrivilege* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFCheckPrivilegeResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapCheckPrivilege*) apiSoapCheckPrivilege; 

@end

@interface ZFApiSoapCheckPrivilege (ValueProperties) 
@end


@interface ZFApiSoapCheckPrivilege (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFCheckPrivilege* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFCheckPrivilegeResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

