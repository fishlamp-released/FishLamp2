//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetReorderPhotoSet.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Reorders photoset elements based on the specified sort order. <A href="/zf/help/api/ref/methods/reorderphotoset">More...</A>
*/



@class ZFReorderPhotoSetHttpGetIn;
@class ZFReorderPhotoSetHttpGetOut;

// --------------------------------------------------------------------
// ZFApiHttpGetReorderPhotoSet
// --------------------------------------------------------------------
@interface ZFApiHttpGetReorderPhotoSet : NSObject{ 
@private
	ZFReorderPhotoSetHttpGetIn* _input;
	ZFReorderPhotoSetHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFReorderPhotoSetHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFReorderPhotoSetHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetReorderPhotoSet*) apiHttpGetReorderPhotoSet; 

@end

@interface ZFApiHttpGetReorderPhotoSet (ValueProperties) 
@end


@interface ZFApiHttpGetReorderPhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFReorderPhotoSetHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFReorderPhotoSetHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

