//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetDeleteGroup.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Deletes a Group. <A href="/zf/help/api/ref/methods/deletegroup">More...</A>
*/



@class FLZfDeleteGroupHttpGetIn;
@class FLZfDeleteGroupHttpGetOut;

// --------------------------------------------------------------------
// FLZfApiHttpGetDeleteGroup
// --------------------------------------------------------------------
@interface FLZfApiHttpGetDeleteGroup : NSObject{ 
@private
	FLZfDeleteGroupHttpGetIn* _input;
	FLZfDeleteGroupHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfDeleteGroupHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfDeleteGroupHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetDeleteGroup*) apiHttpGetDeleteGroup; 

@end

@interface FLZfApiHttpGetDeleteGroup (ValueProperties) 
@end


@interface FLZfApiHttpGetDeleteGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfDeleteGroupHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfDeleteGroupHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

