//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapGetPopularPhotos.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Retrieves photos in order of popularity (most viewed at the top). <A href="/Zenfolio/help/api/ref/methods/getpopularphotos">More...</A>
*/



@class FLZenfolioGetPopularPhotos;
@class FLZenfolioGetPopularPhotosResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapGetPopularPhotos
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapGetPopularPhotos : NSObject{ 
@private
	FLZenfolioGetPopularPhotos* _input;
	FLZenfolioGetPopularPhotosResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetPopularPhotos* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioGetPopularPhotosResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapGetPopularPhotos*) apiSoapGetPopularPhotos; 

@end

@interface FLZenfolioApiSoapGetPopularPhotos (ValueProperties) 
@end


@interface FLZenfolioApiSoapGetPopularPhotos (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetPopularPhotos* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioGetPopularPhotosResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

