//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetReorderPhotoSet.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Reorders photoset elements based on the specified sort order. <A href="/zf/help/api/ref/methods/reorderphotoset">More...</A>
*/



@class FLZfReorderPhotoSetHttpGetIn;
@class FLZfReorderPhotoSetHttpGetOut;

// --------------------------------------------------------------------
// FLZfApiHttpGetReorderPhotoSet
// --------------------------------------------------------------------
@interface FLZfApiHttpGetReorderPhotoSet : NSObject{ 
@private
	FLZfReorderPhotoSetHttpGetIn* _input;
	FLZfReorderPhotoSetHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfReorderPhotoSetHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfReorderPhotoSetHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetReorderPhotoSet*) apiHttpGetReorderPhotoSet; 

@end

@interface FLZfApiHttpGetReorderPhotoSet (ValueProperties) 
@end


@interface FLZfApiHttpGetReorderPhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfReorderPhotoSetHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfReorderPhotoSetHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

