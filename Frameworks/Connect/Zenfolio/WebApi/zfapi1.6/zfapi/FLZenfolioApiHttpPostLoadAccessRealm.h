//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostLoadAccessRealm.h
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



@class FLZenfolioLoadAccessRealmHttpPostIn;
@class FLZenfolioAccessDescriptor;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostLoadAccessRealm
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostLoadAccessRealm : NSObject{ 
@private
	FLZenfolioLoadAccessRealmHttpPostIn* _input;
	FLZenfolioAccessDescriptor* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioLoadAccessRealmHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioAccessDescriptor* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostLoadAccessRealm*) apiHttpPostLoadAccessRealm; 

@end

@interface FLZenfolioApiHttpPostLoadAccessRealm (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostLoadAccessRealm (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioLoadAccessRealmHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioAccessDescriptor* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

