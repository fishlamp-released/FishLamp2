//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapUpdatePhotoAccess.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Updates photo access descriptor. <A href="/Zenfolio/help/api/ref/methods/updatephotoaccess">More...</A>
*/



@class FLZenfolioUpdatePhotoAccess;
@class FLZenfolioUpdatePhotoAccessResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapUpdatePhotoAccess
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapUpdatePhotoAccess : NSObject{ 
@private
	FLZenfolioUpdatePhotoAccess* _input;
	FLZenfolioUpdatePhotoAccessResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioUpdatePhotoAccess* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioUpdatePhotoAccessResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapUpdatePhotoAccess*) apiSoapUpdatePhotoAccess; 

@end

@interface FLZenfolioApiSoapUpdatePhotoAccess (ValueProperties) 
@end


@interface FLZenfolioApiSoapUpdatePhotoAccess (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioUpdatePhotoAccess* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioUpdatePhotoAccessResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

