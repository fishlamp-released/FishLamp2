//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostLoadPublicProfile.h
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



@class FLZfLoadPublicProfileHttpPostIn;
@class FLZfUser;

// --------------------------------------------------------------------
// FLZfApiHttpPostLoadPublicProfile
// --------------------------------------------------------------------
@interface FLZfApiHttpPostLoadPublicProfile : NSObject{ 
@private
	FLZfLoadPublicProfileHttpPostIn* _input;
	FLZfUser* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadPublicProfileHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfUser* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostLoadPublicProfile*) apiHttpPostLoadPublicProfile; 

@end

@interface FLZfApiHttpPostLoadPublicProfile (ValueProperties) 
@end


@interface FLZfApiHttpPostLoadPublicProfile (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadPublicProfileHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfUser* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

