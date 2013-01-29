//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetReindexPhotoSet.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Reorders photoset elements. <A href="/zf/help/api/ref/methods/reindexphotoset">More...</A>
*/



@class FLZfReindexPhotoSetHttpGetIn;
@class FLZfReindexPhotoSetHttpGetOut;

// --------------------------------------------------------------------
// FLZfApiHttpGetReindexPhotoSet
// --------------------------------------------------------------------
@interface FLZfApiHttpGetReindexPhotoSet : NSObject{ 
@private
	FLZfReindexPhotoSetHttpGetIn* _input;
	FLZfReindexPhotoSetHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfReindexPhotoSetHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfReindexPhotoSetHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetReindexPhotoSet*) apiHttpGetReindexPhotoSet; 

@end

@interface FLZfApiHttpGetReindexPhotoSet (ValueProperties) 
@end


@interface FLZfApiHttpGetReindexPhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfReindexPhotoSetHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfReindexPhotoSetHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

