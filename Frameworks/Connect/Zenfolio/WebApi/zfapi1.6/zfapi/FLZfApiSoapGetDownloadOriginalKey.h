//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapGetDownloadOriginalKey.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Creates a download original key for the provided list of photos.<A href="/zf/help/api/ref/methods/getdownloadoriginalkey">More...</A>
*/



@class FLZfGetDownloadOriginalKey;
@class FLZfGetDownloadOriginalKeyResponse;

// --------------------------------------------------------------------
// FLZfApiSoapGetDownloadOriginalKey
// --------------------------------------------------------------------
@interface FLZfApiSoapGetDownloadOriginalKey : NSObject{ 
@private
	FLZfGetDownloadOriginalKey* _input;
	FLZfGetDownloadOriginalKeyResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfGetDownloadOriginalKey* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfGetDownloadOriginalKeyResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapGetDownloadOriginalKey*) apiSoapGetDownloadOriginalKey; 

@end

@interface FLZfApiSoapGetDownloadOriginalKey (ValueProperties) 
@end


@interface FLZfApiSoapGetDownloadOriginalKey (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfGetDownloadOriginalKey* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfGetDownloadOriginalKeyResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

