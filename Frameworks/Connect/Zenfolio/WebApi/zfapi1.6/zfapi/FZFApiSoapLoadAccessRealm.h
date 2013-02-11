//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapLoadAccessRealm.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads the specified access realm. <A href="/Zenfolio/help/api/ref/methods/loadaccessrealm">More...</A>
*/



@class FLZenfolioLoadAccessRealm;
@class FLZenfolioLoadAccessRealmResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapLoadAccessRealm
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapLoadAccessRealm : NSObject{ 
@private
	FLZenfolioLoadAccessRealm* _input;
	FLZenfolioLoadAccessRealmResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioLoadAccessRealm* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioLoadAccessRealmResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapLoadAccessRealm*) apiSoapLoadAccessRealm; 

@end

@interface FLZenfolioApiSoapLoadAccessRealm (ValueProperties) 
@end


@interface FLZenfolioApiSoapLoadAccessRealm (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioLoadAccessRealm* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioLoadAccessRealmResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

