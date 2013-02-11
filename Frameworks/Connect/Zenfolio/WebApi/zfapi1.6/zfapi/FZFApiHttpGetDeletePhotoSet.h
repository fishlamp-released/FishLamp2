//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetDeletePhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Deletes a photoset. <A href="/Zenfolio/help/api/ref/methods/deletephotoset">More...</A>
*/



@class FLZenfolioDeletePhotoSetHttpGetIn;
@class FLZenfolioDeletePhotoSetHttpGetOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetDeletePhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetDeletePhotoSet : NSObject{ 
@private
	FLZenfolioDeletePhotoSetHttpGetIn* _input;
	FLZenfolioDeletePhotoSetHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioDeletePhotoSetHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioDeletePhotoSetHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetDeletePhotoSet*) apiHttpGetDeletePhotoSet; 

@end

@interface FLZenfolioApiHttpGetDeletePhotoSet (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetDeletePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioDeletePhotoSetHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioDeletePhotoSetHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

