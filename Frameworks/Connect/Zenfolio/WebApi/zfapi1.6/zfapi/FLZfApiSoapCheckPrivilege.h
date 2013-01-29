//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapCheckPrivilege.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Checks if the the specified user is granted a privilege. <A href="/zf/help/api/ref/methods/checkprivilege">More...</A>
*/



@class FLZfCheckPrivilege;
@class FLZfCheckPrivilegeResponse;

// --------------------------------------------------------------------
// FLZfApiSoapCheckPrivilege
// --------------------------------------------------------------------
@interface FLZfApiSoapCheckPrivilege : NSObject{ 
@private
	FLZfCheckPrivilege* _input;
	FLZfCheckPrivilegeResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfCheckPrivilege* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfCheckPrivilegeResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapCheckPrivilege*) apiSoapCheckPrivilege; 

@end

@interface FLZfApiSoapCheckPrivilege (ValueProperties) 
@end


@interface FLZfApiSoapCheckPrivilege (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfCheckPrivilege* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfCheckPrivilegeResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

