//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostLoadAccessRealm.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads the specified access realm. <A href="/Zenfolio/help/api/ref/methods/loadaccessrealm">More...</A>
*/



@class ZFLoadAccessRealmHttpPostIn;
@class ZFAccessDescriptor;

// --------------------------------------------------------------------
// ZFApiHttpPostLoadAccessRealm
// --------------------------------------------------------------------
@interface ZFApiHttpPostLoadAccessRealm : NSObject{ 
@private
	ZFLoadAccessRealmHttpPostIn* _input;
	ZFAccessDescriptor* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadAccessRealmHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFAccessDescriptor* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostLoadAccessRealm*) apiHttpPostLoadAccessRealm; 

@end

@interface ZFApiHttpPostLoadAccessRealm (ValueProperties) 
@end


@interface ZFApiHttpPostLoadAccessRealm (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadAccessRealmHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFAccessDescriptor* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

