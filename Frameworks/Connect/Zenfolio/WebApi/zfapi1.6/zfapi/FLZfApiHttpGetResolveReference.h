//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetResolveReference.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Resolves a group or gallery reference. <A href="/zf/help/api/ref/methods/resolvereference">More...</A>
*/



@class FLZfResolveReferenceHttpGetIn;
@class FLZfResolveResult;

// --------------------------------------------------------------------
// FLZfApiHttpGetResolveReference
// --------------------------------------------------------------------
@interface FLZfApiHttpGetResolveReference : NSObject{ 
@private
	FLZfResolveReferenceHttpGetIn* _input;
	FLZfResolveResult* _output;
} 


@property (readwrite, retain, nonatomic) FLZfResolveReferenceHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfResolveResult* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetResolveReference*) apiHttpGetResolveReference; 

@end

@interface FLZfApiHttpGetResolveReference (ValueProperties) 
@end


@interface FLZfApiHttpGetResolveReference (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfResolveReferenceHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfResolveResult* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

