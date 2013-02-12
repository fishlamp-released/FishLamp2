//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapKeyringGetUnlockedRealms.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Returns a list of realms unlocked by this keyring. <A href="/Zenfolio/help/api/ref/methods/keyringgetunlockedrealms">More...</A>
*/



@class FLZenfolioKeyringGetUnlockedRealms;
@class FLZenfolioKeyringGetUnlockedRealmsResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapKeyringGetUnlockedRealms
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapKeyringGetUnlockedRealms : NSObject{ 
@private
	FLZenfolioKeyringGetUnlockedRealms* _input;
	FLZenfolioKeyringGetUnlockedRealmsResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioKeyringGetUnlockedRealms* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioKeyringGetUnlockedRealmsResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapKeyringGetUnlockedRealms*) apiSoapKeyringGetUnlockedRealms; 

@end

@interface FLZenfolioApiSoapKeyringGetUnlockedRealms (ValueProperties) 
@end


@interface FLZenfolioApiSoapKeyringGetUnlockedRealms (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioKeyringGetUnlockedRealms* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioKeyringGetUnlockedRealmsResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

