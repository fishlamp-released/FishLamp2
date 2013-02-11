//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapLoadPrivateProfile.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads the private profile of the current user. <A href="/Zenfolio/help/api/ref/methods/loadprivateprofile">More...</A>
*/



@class FLZenfolioLoadPrivateProfile;
@class FLZenfolioLoadPrivateProfileResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapLoadPrivateProfile
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapLoadPrivateProfile : NSObject{ 
@private
	FLZenfolioLoadPrivateProfile* _input;
	FLZenfolioLoadPrivateProfileResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioLoadPrivateProfile* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioLoadPrivateProfileResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapLoadPrivateProfile*) apiSoapLoadPrivateProfile; 

@end

@interface FLZenfolioApiSoapLoadPrivateProfile (ValueProperties) 
@end


@interface FLZenfolioApiSoapLoadPrivateProfile (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioLoadPrivateProfile* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioLoadPrivateProfileResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

