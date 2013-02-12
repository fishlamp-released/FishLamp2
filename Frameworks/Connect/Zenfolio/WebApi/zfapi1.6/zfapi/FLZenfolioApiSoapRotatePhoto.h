//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapRotatePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Rotates a photo. <a href="/Zenfolio/help/api/ref/methods/rotatephoto">More ...</a>
*/



@class FLZenfolioRotatePhoto;
@class FLZenfolioRotatePhotoResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapRotatePhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapRotatePhoto : NSObject{ 
@private
	FLZenfolioRotatePhoto* _input;
	FLZenfolioRotatePhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioRotatePhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioRotatePhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapRotatePhoto*) apiSoapRotatePhoto; 

@end

@interface FLZenfolioApiSoapRotatePhoto (ValueProperties) 
@end


@interface FLZenfolioApiSoapRotatePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioRotatePhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioRotatePhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

