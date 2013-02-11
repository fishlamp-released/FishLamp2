//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetGetVisitorKey.h
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



@class FLZenfolioGetVisitorKeyHttpGetIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetGetVisitorKey
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetGetVisitorKey : NSObject{ 
@private
	FLZenfolioGetVisitorKeyHttpGetIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetVisitorKeyHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetGetVisitorKey*) apiHttpGetGetVisitorKey; 

@end

@interface FLZenfolioApiHttpGetGetVisitorKey (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetGetVisitorKey (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetVisitorKeyHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

