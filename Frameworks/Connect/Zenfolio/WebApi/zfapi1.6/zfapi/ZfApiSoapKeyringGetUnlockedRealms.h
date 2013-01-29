//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapKeyringGetUnlockedRealms.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Returns a list of realms unlocked by this keyring. <A href="/zf/help/api/ref/methods/keyringgetunlockedrealms">More...</A>
*/



@class ZFKeyringGetUnlockedRealms;
@class ZFKeyringGetUnlockedRealmsResponse;

// --------------------------------------------------------------------
// ZFApiSoapKeyringGetUnlockedRealms
// --------------------------------------------------------------------
@interface ZFApiSoapKeyringGetUnlockedRealms : NSObject{ 
@private
	ZFKeyringGetUnlockedRealms* _input;
	ZFKeyringGetUnlockedRealmsResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFKeyringGetUnlockedRealms* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFKeyringGetUnlockedRealmsResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapKeyringGetUnlockedRealms*) apiSoapKeyringGetUnlockedRealms; 

@end

@interface ZFApiSoapKeyringGetUnlockedRealms (ValueProperties) 
@end


@interface ZFApiSoapKeyringGetUnlockedRealms (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFKeyringGetUnlockedRealms* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFKeyringGetUnlockedRealmsResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

