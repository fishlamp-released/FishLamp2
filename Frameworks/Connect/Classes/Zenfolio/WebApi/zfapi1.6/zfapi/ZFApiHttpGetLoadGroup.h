//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetLoadGroup.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads the specified group. <A href="/Zenfolio/help/api/ref/methods/loadgroup">More...</A>
*/



@class ZFLoadGroupHttpGetIn;
@class ZFGroup;

// --------------------------------------------------------------------
// ZFApiHttpGetLoadGroup
// --------------------------------------------------------------------
@interface ZFApiHttpGetLoadGroup : NSObject{ 
@private
	ZFLoadGroupHttpGetIn* _input;
	ZFGroup* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadGroupHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFGroup* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetLoadGroup*) apiHttpGetLoadGroup; 

@end

@interface ZFApiHttpGetLoadGroup (ValueProperties) 
@end


@interface ZFApiHttpGetLoadGroup (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadGroupHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFGroup* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

