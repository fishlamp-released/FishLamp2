//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostLoadPublicProfile.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads the public profile of the specified user. <A href="/Zenfolio/help/api/ref/methods/loadpublicprofile">More...</A>
*/



@class FLZenfolioLoadPublicProfileHttpPostIn;
@class FLZenfolioUser;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostLoadPublicProfile
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostLoadPublicProfile : NSObject{ 
@private
	FLZenfolioLoadPublicProfileHttpPostIn* _input;
	FLZenfolioUser* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioLoadPublicProfileHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioUser* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostLoadPublicProfile*) apiHttpPostLoadPublicProfile; 

@end

@interface FLZenfolioApiHttpPostLoadPublicProfile (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostLoadPublicProfile (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioLoadPublicProfileHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioUser* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

