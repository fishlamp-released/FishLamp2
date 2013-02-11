//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostGetDownloadOriginalKey.h
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



@class FLZenfolioGetDownloadOriginalKeyHttpPostIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostGetDownloadOriginalKey
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostGetDownloadOriginalKey : NSObject{ 
@private
	FLZenfolioGetDownloadOriginalKeyHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetDownloadOriginalKeyHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostGetDownloadOriginalKey*) apiHttpPostGetDownloadOriginalKey; 

@end

@interface FLZenfolioApiHttpPostGetDownloadOriginalKey (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostGetDownloadOriginalKey (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetDownloadOriginalKeyHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

