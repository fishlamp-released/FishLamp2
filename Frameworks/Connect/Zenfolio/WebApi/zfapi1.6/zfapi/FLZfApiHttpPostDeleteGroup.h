//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostDeleteGroup.h
//	Project: myZenfolio WebAPI
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



@class FLZfDeleteGroupHttpPostIn;
@class FLZfDeleteGroupHttpPostOut;

// --------------------------------------------------------------------
// FLZfApiHttpPostDeleteGroup
// --------------------------------------------------------------------
@interface FLZfApiHttpPostDeleteGroup : NSObject{ 
@private
	FLZfDeleteGroupHttpPostIn* _input;
	FLZfDeleteGroupHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfDeleteGroupHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfDeleteGroupHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostDeleteGroup*) apiHttpPostDeleteGroup; 

@end

@interface FLZfApiHttpPostDeleteGroup (ValueProperties) 
@end


@interface FLZfApiHttpPostDeleteGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfDeleteGroupHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfDeleteGroupHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

