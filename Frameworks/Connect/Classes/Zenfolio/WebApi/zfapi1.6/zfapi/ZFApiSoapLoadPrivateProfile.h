//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapLoadPrivateProfile.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads the private profile of the current user. <A href="/Zenfolio/help/api/ref/methods/loadprivateprofile">More...</A>
*/



@class ZFLoadPrivateProfile;
@class ZFLoadPrivateProfileResponse;

// --------------------------------------------------------------------
// ZFApiSoapLoadPrivateProfile
// --------------------------------------------------------------------
@interface ZFApiSoapLoadPrivateProfile : NSObject{ 
@private
	ZFLoadPrivateProfile* _input;
	ZFLoadPrivateProfileResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadPrivateProfile* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFLoadPrivateProfileResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapLoadPrivateProfile*) apiSoapLoadPrivateProfile; 

@end

@interface ZFApiSoapLoadPrivateProfile (ValueProperties) 
@end


@interface ZFApiSoapLoadPrivateProfile (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadPrivateProfile* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFLoadPrivateProfileResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

