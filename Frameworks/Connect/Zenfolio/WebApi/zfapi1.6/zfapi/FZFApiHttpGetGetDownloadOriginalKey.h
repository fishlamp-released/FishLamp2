//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetGetDownloadOriginalKey.h
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



@class FLZenfolioGetDownloadOriginalKeyHttpGetIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetGetDownloadOriginalKey
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetGetDownloadOriginalKey : NSObject{ 
@private
	FLZenfolioGetDownloadOriginalKeyHttpGetIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetDownloadOriginalKeyHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetGetDownloadOriginalKey*) apiHttpGetGetDownloadOriginalKey; 

@end

@interface FLZenfolioApiHttpGetGetDownloadOriginalKey (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetGetDownloadOriginalKey (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetDownloadOriginalKeyHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

