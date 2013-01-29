//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetReorderGroup.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Reorders group elements based on the specified sort order. <A href="/zf/help/api/ref/methods/reordergroup">More...</A>
*/



@class ZFReorderGroupHttpGetIn;
@class ZFReorderGroupHttpGetOut;

// --------------------------------------------------------------------
// ZFApiHttpGetReorderGroup
// --------------------------------------------------------------------
@interface ZFApiHttpGetReorderGroup : NSObject{ 
@private
	ZFReorderGroupHttpGetIn* _input;
	ZFReorderGroupHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFReorderGroupHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFReorderGroupHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetReorderGroup*) apiHttpGetReorderGroup; 

@end

@interface ZFApiHttpGetReorderGroup (ValueProperties) 
@end


@interface ZFApiHttpGetReorderGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFReorderGroupHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFReorderGroupHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

