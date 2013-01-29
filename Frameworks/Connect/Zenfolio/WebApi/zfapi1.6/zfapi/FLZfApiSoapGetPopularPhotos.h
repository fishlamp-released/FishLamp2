//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapGetPopularPhotos.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Retrieves photos in order of popularity (most viewed at the top). <A href="/zf/help/api/ref/methods/getpopularphotos">More...</A>
*/



@class FLZfGetPopularPhotos;
@class FLZfGetPopularPhotosResponse;

// --------------------------------------------------------------------
// FLZfApiSoapGetPopularPhotos
// --------------------------------------------------------------------
@interface FLZfApiSoapGetPopularPhotos : NSObject{ 
@private
	FLZfGetPopularPhotos* _input;
	FLZfGetPopularPhotosResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfGetPopularPhotos* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfGetPopularPhotosResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapGetPopularPhotos*) apiSoapGetPopularPhotos; 

@end

@interface FLZfApiSoapGetPopularPhotos (ValueProperties) 
@end


@interface FLZfApiSoapGetPopularPhotos (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfGetPopularPhotos* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfGetPopularPhotosResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

