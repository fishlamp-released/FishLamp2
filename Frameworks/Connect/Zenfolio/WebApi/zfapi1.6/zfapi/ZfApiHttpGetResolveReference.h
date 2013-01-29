//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetResolveReference.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Resolves a group or gallery reference. <A href="/zf/help/api/ref/methods/resolvereference">More...</A>
*/



@class ZFResolveReferenceHttpGetIn;
@class ZFResolveResult;

// --------------------------------------------------------------------
// ZFApiHttpGetResolveReference
// --------------------------------------------------------------------
@interface ZFApiHttpGetResolveReference : NSObject{ 
@private
	ZFResolveReferenceHttpGetIn* _input;
	ZFResolveResult* _output;
} 


@property (readwrite, retain, nonatomic) ZFResolveReferenceHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFResolveResult* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetResolveReference*) apiHttpGetResolveReference; 

@end

@interface ZFApiHttpGetResolveReference (ValueProperties) 
@end


@interface ZFApiHttpGetResolveReference (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFResolveReferenceHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFResolveResult* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

