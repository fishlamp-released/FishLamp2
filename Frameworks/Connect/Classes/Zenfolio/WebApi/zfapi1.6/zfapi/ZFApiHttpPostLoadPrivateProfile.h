//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostLoadPrivateProfile.h
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



@class ZFLoadPrivateProfileHttpPostIn;
@class ZFUser;

// --------------------------------------------------------------------
// ZFApiHttpPostLoadPrivateProfile
// --------------------------------------------------------------------
@interface ZFApiHttpPostLoadPrivateProfile : NSObject{ 
@private
	ZFLoadPrivateProfileHttpPostIn* _input;
	ZFUser* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadPrivateProfileHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFUser* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostLoadPrivateProfile*) apiHttpPostLoadPrivateProfile; 

@end

@interface ZFApiHttpPostLoadPrivateProfile (ValueProperties) 
@end


@interface ZFApiHttpPostLoadPrivateProfile (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadPrivateProfileHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFUser* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

