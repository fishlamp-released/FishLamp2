//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetLoadAccessRealm.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Loads the specified access realm. <A href="/zf/help/api/ref/methods/loadaccessrealm">More...</A>
*/



@class FLZfLoadAccessRealmHttpGetIn;
@class FLZfAccessDescriptor;

// --------------------------------------------------------------------
// FLZfApiHttpGetLoadAccessRealm
// --------------------------------------------------------------------
@interface FLZfApiHttpGetLoadAccessRealm : NSObject{ 
@private
	FLZfLoadAccessRealmHttpGetIn* _input;
	FLZfAccessDescriptor* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadAccessRealmHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfAccessDescriptor* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetLoadAccessRealm*) apiHttpGetLoadAccessRealm; 

@end

@interface FLZfApiHttpGetLoadAccessRealm (ValueProperties) 
@end


@interface FLZfApiHttpGetLoadAccessRealm (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadAccessRealmHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfAccessDescriptor* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

