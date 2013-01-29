//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapLoadPublicProfile.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Loads the public profile of the specified user. <A href="/zf/help/api/ref/methods/loadpublicprofile">More...</A>
*/



@class FLZfLoadPublicProfile;
@class FLZfLoadPublicProfileResponse;

// --------------------------------------------------------------------
// FLZfApiSoapLoadPublicProfile
// --------------------------------------------------------------------
@interface FLZfApiSoapLoadPublicProfile : NSObject{ 
@private
	FLZfLoadPublicProfile* _input;
	FLZfLoadPublicProfileResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadPublicProfile* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfLoadPublicProfileResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapLoadPublicProfile*) apiSoapLoadPublicProfile; 

@end

@interface FLZfApiSoapLoadPublicProfile (ValueProperties) 
@end


@interface FLZfApiSoapLoadPublicProfile (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadPublicProfile* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfLoadPublicProfileResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

