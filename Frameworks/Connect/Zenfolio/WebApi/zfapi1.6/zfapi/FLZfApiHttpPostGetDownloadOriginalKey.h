//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostGetDownloadOriginalKey.h
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



@class FLZfGetDownloadOriginalKeyHttpPostIn;

// --------------------------------------------------------------------
// FLZfApiHttpPostGetDownloadOriginalKey
// --------------------------------------------------------------------
@interface FLZfApiHttpPostGetDownloadOriginalKey : NSObject{ 
@private
	FLZfGetDownloadOriginalKeyHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZfGetDownloadOriginalKeyHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostGetDownloadOriginalKey*) apiHttpPostGetDownloadOriginalKey; 

@end

@interface FLZfApiHttpPostGetDownloadOriginalKey (ValueProperties) 
@end


@interface FLZfApiHttpPostGetDownloadOriginalKey (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfGetDownloadOriginalKeyHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

