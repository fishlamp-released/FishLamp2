//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostGetVisitorKey.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Returns the visitor key of the currently authenticated user. <A href="/Zenfolio/help/api/ref/methods/getvisitorkey">More...</A>
*/



@class FLZenfolioGetVisitorKeyHttpPostIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostGetVisitorKey
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostGetVisitorKey : NSObject{ 
@private
	FLZenfolioGetVisitorKeyHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetVisitorKeyHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostGetVisitorKey*) apiHttpPostGetVisitorKey; 

@end

@interface FLZenfolioApiHttpPostGetVisitorKey (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostGetVisitorKey (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetVisitorKeyHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

