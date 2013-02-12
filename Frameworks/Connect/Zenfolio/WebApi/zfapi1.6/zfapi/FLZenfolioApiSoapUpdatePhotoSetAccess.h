//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapUpdatePhotoSetAccess.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Updates photoset access descriptor. <A href="/Zenfolio/help/api/ref/methods/updatephotosetaccess">More...</A>
*/



@class FLZenfolioUpdatePhotoSetAccess;
@class FLZenfolioUpdatePhotoSetAccessResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapUpdatePhotoSetAccess
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapUpdatePhotoSetAccess : NSObject{ 
@private
	FLZenfolioUpdatePhotoSetAccess* _input;
	FLZenfolioUpdatePhotoSetAccessResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioUpdatePhotoSetAccess* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioUpdatePhotoSetAccessResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapUpdatePhotoSetAccess*) apiSoapUpdatePhotoSetAccess; 

@end

@interface FLZenfolioApiSoapUpdatePhotoSetAccess (ValueProperties) 
@end


@interface FLZenfolioApiSoapUpdatePhotoSetAccess (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioUpdatePhotoSetAccess* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioUpdatePhotoSetAccessResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

