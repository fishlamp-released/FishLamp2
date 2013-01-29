//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapGetDownloadOriginalKey.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Creates a download original key for the provided list of photos.<A href="/zf/help/api/ref/methods/getdownloadoriginalkey">More...</A>
*/



@class ZFGetDownloadOriginalKey;
@class ZFGetDownloadOriginalKeyResponse;

// --------------------------------------------------------------------
// ZFApiSoapGetDownloadOriginalKey
// --------------------------------------------------------------------
@interface ZFApiSoapGetDownloadOriginalKey : NSObject{ 
@private
	ZFGetDownloadOriginalKey* _input;
	ZFGetDownloadOriginalKeyResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetDownloadOriginalKey* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFGetDownloadOriginalKeyResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapGetDownloadOriginalKey*) apiSoapGetDownloadOriginalKey; 

@end

@interface ZFApiSoapGetDownloadOriginalKey (ValueProperties) 
@end


@interface ZFApiSoapGetDownloadOriginalKey (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetDownloadOriginalKey* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFGetDownloadOriginalKeyResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

