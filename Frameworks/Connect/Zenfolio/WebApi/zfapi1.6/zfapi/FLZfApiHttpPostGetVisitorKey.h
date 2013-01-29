//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostGetVisitorKey.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Returns the visitor key of the currently authenticated user. <A href="/zf/help/api/ref/methods/getvisitorkey">More...</A>
*/



@class FLZfGetVisitorKeyHttpPostIn;

// --------------------------------------------------------------------
// FLZfApiHttpPostGetVisitorKey
// --------------------------------------------------------------------
@interface FLZfApiHttpPostGetVisitorKey : NSObject{ 
@private
	FLZfGetVisitorKeyHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZfGetVisitorKeyHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostGetVisitorKey*) apiHttpPostGetVisitorKey; 

@end

@interface FLZfApiHttpPostGetVisitorKey (ValueProperties) 
@end


@interface FLZfApiHttpPostGetVisitorKey (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfGetVisitorKeyHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

