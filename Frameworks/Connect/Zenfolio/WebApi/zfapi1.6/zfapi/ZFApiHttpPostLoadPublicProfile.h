//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostLoadPublicProfile.h
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



@class ZFLoadPublicProfileHttpPostIn;
@class ZFUser;

// --------------------------------------------------------------------
// ZFApiHttpPostLoadPublicProfile
// --------------------------------------------------------------------
@interface ZFApiHttpPostLoadPublicProfile : NSObject{ 
@private
	ZFLoadPublicProfileHttpPostIn* _input;
	ZFUser* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadPublicProfileHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFUser* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostLoadPublicProfile*) apiHttpPostLoadPublicProfile; 

@end

@interface ZFApiHttpPostLoadPublicProfile (ValueProperties) 
@end


@interface ZFApiHttpPostLoadPublicProfile (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadPublicProfileHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFUser* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end
