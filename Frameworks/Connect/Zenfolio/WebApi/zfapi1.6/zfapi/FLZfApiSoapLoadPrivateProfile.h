//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapLoadPrivateProfile.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Loads the private profile of the current user. <A href="/zf/help/api/ref/methods/loadprivateprofile">More...</A>
*/



@class FLZfLoadPrivateProfile;
@class FLZfLoadPrivateProfileResponse;

// --------------------------------------------------------------------
// FLZfApiSoapLoadPrivateProfile
// --------------------------------------------------------------------
@interface FLZfApiSoapLoadPrivateProfile : NSObject{ 
@private
	FLZfLoadPrivateProfile* _input;
	FLZfLoadPrivateProfileResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadPrivateProfile* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfLoadPrivateProfileResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapLoadPrivateProfile*) apiSoapLoadPrivateProfile; 

@end

@interface FLZfApiSoapLoadPrivateProfile (ValueProperties) 
@end


@interface FLZfApiSoapLoadPrivateProfile (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadPrivateProfile* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfLoadPrivateProfileResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

