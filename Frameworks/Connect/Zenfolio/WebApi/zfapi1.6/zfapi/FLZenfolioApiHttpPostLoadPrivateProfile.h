//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostLoadPrivateProfile.h
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



@class FLZenfolioLoadPrivateProfileHttpPostIn;
@class FLZenfolioUser;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostLoadPrivateProfile
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostLoadPrivateProfile : NSObject{ 
@private
	FLZenfolioLoadPrivateProfileHttpPostIn* _input;
	FLZenfolioUser* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioLoadPrivateProfileHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioUser* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostLoadPrivateProfile*) apiHttpPostLoadPrivateProfile; 

@end

@interface FLZenfolioApiHttpPostLoadPrivateProfile (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostLoadPrivateProfile (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioLoadPrivateProfileHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioUser* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

