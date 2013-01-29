//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetGetVisitorKey.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Returns the visitor key of the currently authenticated user. <A href="/zf/help/api/ref/methods/getvisitorkey">More...</A>
*/



@class ZFGetVisitorKeyHttpGetIn;

// --------------------------------------------------------------------
// ZFApiHttpGetGetVisitorKey
// --------------------------------------------------------------------
@interface ZFApiHttpGetGetVisitorKey : NSObject{ 
@private
	ZFGetVisitorKeyHttpGetIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetVisitorKeyHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetGetVisitorKey*) apiHttpGetGetVisitorKey; 

@end

@interface ZFApiHttpGetGetVisitorKey (ValueProperties) 
@end


@interface ZFApiHttpGetGetVisitorKey (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetVisitorKeyHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

