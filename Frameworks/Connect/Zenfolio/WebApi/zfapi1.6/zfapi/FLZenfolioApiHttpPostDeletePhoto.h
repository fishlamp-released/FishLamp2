//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostDeletePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Deletes a photo. <A href="/Zenfolio/help/api/ref/methods/deletephoto">More...</A>
*/



@class FLZenfolioDeletePhotoHttpPostIn;
@class FLZenfolioDeletePhotoHttpPostOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostDeletePhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostDeletePhoto : NSObject{ 
@private
	FLZenfolioDeletePhotoHttpPostIn* _input;
	FLZenfolioDeletePhotoHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioDeletePhotoHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioDeletePhotoHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostDeletePhoto*) apiHttpPostDeletePhoto; 

@end

@interface FLZenfolioApiHttpPostDeletePhoto (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostDeletePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioDeletePhotoHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioDeletePhotoHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

