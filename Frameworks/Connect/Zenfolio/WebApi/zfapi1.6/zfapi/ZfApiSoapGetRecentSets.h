//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapGetRecentSets.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Retrieves recently added photo sets (most recent at the top). <A href="/zf/help/api/ref/methods/getrecentsets">More...</A>
*/



@class ZFGetRecentSets;
@class ZFGetRecentSetsResponse;

// --------------------------------------------------------------------
// ZFApiSoapGetRecentSets
// --------------------------------------------------------------------
@interface ZFApiSoapGetRecentSets : NSObject{ 
@private
	ZFGetRecentSets* _input;
	ZFGetRecentSetsResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetRecentSets* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFGetRecentSetsResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapGetRecentSets*) apiSoapGetRecentSets; 

@end

@interface ZFApiSoapGetRecentSets (ValueProperties) 
@end


@interface ZFApiSoapGetRecentSets (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetRecentSets* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFGetRecentSetsResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

