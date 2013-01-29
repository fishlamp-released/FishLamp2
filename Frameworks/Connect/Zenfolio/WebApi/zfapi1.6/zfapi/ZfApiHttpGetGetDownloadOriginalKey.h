//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetGetDownloadOriginalKey.h
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



@class ZFGetDownloadOriginalKeyHttpGetIn;

// --------------------------------------------------------------------
// ZFApiHttpGetGetDownloadOriginalKey
// --------------------------------------------------------------------
@interface ZFApiHttpGetGetDownloadOriginalKey : NSObject{ 
@private
	ZFGetDownloadOriginalKeyHttpGetIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetDownloadOriginalKeyHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetGetDownloadOriginalKey*) apiHttpGetGetDownloadOriginalKey; 

@end

@interface ZFApiHttpGetGetDownloadOriginalKey (ValueProperties) 
@end


@interface ZFApiHttpGetGetDownloadOriginalKey (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetDownloadOriginalKeyHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

