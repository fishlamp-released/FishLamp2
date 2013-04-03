//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostGetVisitorKey.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Returns the visitor key of the currently authenticated user. <A href="/Zenfolio/help/api/ref/methods/getvisitorkey">More...</A>
*/



@class ZFGetVisitorKeyHttpPostIn;

// --------------------------------------------------------------------
// ZFApiHttpPostGetVisitorKey
// --------------------------------------------------------------------
@interface ZFApiHttpPostGetVisitorKey : NSObject{ 
@private
	ZFGetVisitorKeyHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetVisitorKeyHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostGetVisitorKey*) apiHttpPostGetVisitorKey; 

@end

@interface ZFApiHttpPostGetVisitorKey (ValueProperties) 
@end


@interface ZFApiHttpPostGetVisitorKey (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetVisitorKeyHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

