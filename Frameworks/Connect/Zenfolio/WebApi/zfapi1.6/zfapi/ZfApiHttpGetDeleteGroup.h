//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetDeleteGroup.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Deletes a Group. <A href="/zf/help/api/ref/methods/deletegroup">More...</A>
*/



@class ZFDeleteGroupHttpGetIn;
@class ZFDeleteGroupHttpGetOut;

// --------------------------------------------------------------------
// ZFApiHttpGetDeleteGroup
// --------------------------------------------------------------------
@interface ZFApiHttpGetDeleteGroup : NSObject{ 
@private
	ZFDeleteGroupHttpGetIn* _input;
	ZFDeleteGroupHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFDeleteGroupHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFDeleteGroupHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetDeleteGroup*) apiHttpGetDeleteGroup; 

@end

@interface ZFApiHttpGetDeleteGroup (ValueProperties) 
@end


@interface ZFApiHttpGetDeleteGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFDeleteGroupHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFDeleteGroupHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

