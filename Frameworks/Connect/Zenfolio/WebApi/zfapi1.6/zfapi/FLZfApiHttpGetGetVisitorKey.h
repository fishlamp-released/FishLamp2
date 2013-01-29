//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetGetVisitorKey.h
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



@class FLZfGetVisitorKeyHttpGetIn;

// --------------------------------------------------------------------
// FLZfApiHttpGetGetVisitorKey
// --------------------------------------------------------------------
@interface FLZfApiHttpGetGetVisitorKey : NSObject{ 
@private
	FLZfGetVisitorKeyHttpGetIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZfGetVisitorKeyHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetGetVisitorKey*) apiHttpGetGetVisitorKey; 

@end

@interface FLZfApiHttpGetGetVisitorKey (ValueProperties) 
@end


@interface FLZfApiHttpGetGetVisitorKey (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfGetVisitorKeyHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

