//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapCreatePhotoFromUrl.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Creates a photo by downloading the specified URL. <A href="/Zenfolio/help/api/ref/methods/createphotofromurl">More...</A>
*/



@class FLZenfolioCreatePhotoFromUrl;
@class FLZenfolioCreatePhotoFromUrlResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapCreatePhotoFromUrl
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapCreatePhotoFromUrl : NSObject{ 
@private
	FLZenfolioCreatePhotoFromUrl* _input;
	FLZenfolioCreatePhotoFromUrlResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioCreatePhotoFromUrl* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioCreatePhotoFromUrlResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapCreatePhotoFromUrl*) apiSoapCreatePhotoFromUrl; 

@end

@interface FLZenfolioApiSoapCreatePhotoFromUrl (ValueProperties) 
@end


@interface FLZenfolioApiSoapCreatePhotoFromUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioCreatePhotoFromUrl* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioCreatePhotoFromUrlResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

