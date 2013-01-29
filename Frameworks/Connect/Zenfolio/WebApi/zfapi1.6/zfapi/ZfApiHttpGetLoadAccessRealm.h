//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetLoadAccessRealm.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Loads the specified access realm. <A href="/zf/help/api/ref/methods/loadaccessrealm">More...</A>
*/



@class ZFLoadAccessRealmHttpGetIn;
@class ZFAccessDescriptor;

// --------------------------------------------------------------------
// ZFApiHttpGetLoadAccessRealm
// --------------------------------------------------------------------
@interface ZFApiHttpGetLoadAccessRealm : NSObject{ 
@private
	ZFLoadAccessRealmHttpGetIn* _input;
	ZFAccessDescriptor* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadAccessRealmHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFAccessDescriptor* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetLoadAccessRealm*) apiHttpGetLoadAccessRealm; 

@end

@interface ZFApiHttpGetLoadAccessRealm (ValueProperties) 
@end


@interface ZFApiHttpGetLoadAccessRealm (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadAccessRealmHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFAccessDescriptor* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

