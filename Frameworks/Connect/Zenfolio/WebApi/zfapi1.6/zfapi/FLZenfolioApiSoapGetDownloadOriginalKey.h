//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapGetDownloadOriginalKey.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Creates a download original key for the provided list of photos.<A href="/Zenfolio/help/api/ref/methods/getdownloadoriginalkey">More...</A>
*/



@class FLZenfolioGetDownloadOriginalKey;
@class FLZenfolioGetDownloadOriginalKeyResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapGetDownloadOriginalKey
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapGetDownloadOriginalKey : NSObject{ 
@private
	FLZenfolioGetDownloadOriginalKey* _input;
	FLZenfolioGetDownloadOriginalKeyResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetDownloadOriginalKey* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioGetDownloadOriginalKeyResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapGetDownloadOriginalKey*) apiSoapGetDownloadOriginalKey; 

@end

@interface FLZenfolioApiSoapGetDownloadOriginalKey (ValueProperties) 
@end


@interface FLZenfolioApiSoapGetDownloadOriginalKey (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetDownloadOriginalKey* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioGetDownloadOriginalKeyResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

