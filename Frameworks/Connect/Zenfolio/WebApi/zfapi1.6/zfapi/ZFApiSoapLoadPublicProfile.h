//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapLoadPublicProfile.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads the public profile of the specified user. <A href="/Zenfolio/help/api/ref/methods/loadpublicprofile">More...</A>
*/



@class ZFLoadPublicProfile;
@class ZFLoadPublicProfileResponse;

// --------------------------------------------------------------------
// ZFApiSoapLoadPublicProfile
// --------------------------------------------------------------------
@interface ZFApiSoapLoadPublicProfile : NSObject{ 
@private
	ZFLoadPublicProfile* _input;
	ZFLoadPublicProfileResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadPublicProfile* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFLoadPublicProfileResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapLoadPublicProfile*) apiSoapLoadPublicProfile; 

@end

@interface ZFApiSoapLoadPublicProfile (ValueProperties) 
@end


@interface ZFApiSoapLoadPublicProfile (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadPublicProfile* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFLoadPublicProfileResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end
