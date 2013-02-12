//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostLoadPhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads the specified photo. <A href="/Zenfolio/help/api/ref/methods/loadphoto">More...</A>
*/



@class FLZenfolioLoadPhotoHttpPostIn;
@class FLZenfolioPhoto;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostLoadPhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostLoadPhoto : NSObject{ 
@private
	FLZenfolioLoadPhotoHttpPostIn* _input;
	FLZenfolioPhoto* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioLoadPhotoHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioPhoto* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostLoadPhoto*) apiHttpPostLoadPhoto; 

@end

@interface FLZenfolioApiHttpPostLoadPhoto (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostLoadPhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioLoadPhotoHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioPhoto* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

