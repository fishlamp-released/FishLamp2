//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostResolveReference.h
//	Project: myZenfolio WebAPI
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



@class FLZfResolveReferenceHttpPostIn;
@class FLZfResolveResult;

// --------------------------------------------------------------------
// FLZfApiHttpPostResolveReference
// --------------------------------------------------------------------
@interface FLZfApiHttpPostResolveReference : NSObject{ 
@private
	FLZfResolveReferenceHttpPostIn* _input;
	FLZfResolveResult* _output;
} 


@property (readwrite, retain, nonatomic) FLZfResolveReferenceHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfResolveResult* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostResolveReference*) apiHttpPostResolveReference; 

@end

@interface FLZfApiHttpPostResolveReference (ValueProperties) 
@end


@interface FLZfApiHttpPostResolveReference (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfResolveReferenceHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfResolveResult* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

