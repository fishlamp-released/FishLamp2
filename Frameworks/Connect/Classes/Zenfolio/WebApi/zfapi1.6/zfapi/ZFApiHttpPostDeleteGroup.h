//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostDeleteGroup.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Deletes a Group. <A href="/Zenfolio/help/api/ref/methods/deletegroup">More...</A>
*/



@class ZFDeleteGroupHttpPostIn;
@class ZFDeleteGroupHttpPostOut;

// --------------------------------------------------------------------
// ZFApiHttpPostDeleteGroup
// --------------------------------------------------------------------
@interface ZFApiHttpPostDeleteGroup : NSObject{ 
@private
	ZFDeleteGroupHttpPostIn* _input;
	ZFDeleteGroupHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFDeleteGroupHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFDeleteGroupHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostDeleteGroup*) apiHttpPostDeleteGroup; 

@end

@interface ZFApiHttpPostDeleteGroup (ValueProperties) 
@end


@interface ZFApiHttpPostDeleteGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFDeleteGroupHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFDeleteGroupHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

