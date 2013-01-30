//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetReindexPhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Reorders photoset elements. <A href="/Zenfolio/help/api/ref/methods/reindexphotoset">More...</A>
*/



@class FLZenfolioReindexPhotoSetHttpGetIn;
@class FLZenfolioReindexPhotoSetHttpGetOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetReindexPhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetReindexPhotoSet : NSObject{ 
@private
	FLZenfolioReindexPhotoSetHttpGetIn* _input;
	FLZenfolioReindexPhotoSetHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioReindexPhotoSetHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioReindexPhotoSetHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetReindexPhotoSet*) apiHttpGetReindexPhotoSet; 

@end

@interface FLZenfolioApiHttpGetReindexPhotoSet (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetReindexPhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioReindexPhotoSetHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioReindexPhotoSetHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

