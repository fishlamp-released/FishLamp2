//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapCheckPrivilege.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Checks if the the specified user is granted a privilege. <A href="/Zenfolio/help/api/ref/methods/checkprivilege">More...</A>
*/



@class FLZenfolioCheckPrivilege;
@class FLZenfolioCheckPrivilegeResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapCheckPrivilege
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapCheckPrivilege : NSObject{ 
@private
	FLZenfolioCheckPrivilege* _input;
	FLZenfolioCheckPrivilegeResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioCheckPrivilege* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioCheckPrivilegeResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapCheckPrivilege*) apiSoapCheckPrivilege; 

@end

@interface FLZenfolioApiSoapCheckPrivilege (ValueProperties) 
@end


@interface FLZenfolioApiSoapCheckPrivilege (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioCheckPrivilege* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioCheckPrivilegeResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

