//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapReorderPhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Reorders photoset elements based on the specified sort order. <A href="/Zenfolio/help/api/ref/methods/reorderphotoset">More...</A>
*/



@class FLZenfolioReorderPhotoSet;
@class FLZenfolioReorderPhotoSetResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapReorderPhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapReorderPhotoSet : NSObject{ 
@private
	FLZenfolioReorderPhotoSet* _input;
	FLZenfolioReorderPhotoSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioReorderPhotoSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioReorderPhotoSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapReorderPhotoSet*) apiSoapReorderPhotoSet; 

@end

@interface FLZenfolioApiSoapReorderPhotoSet (ValueProperties) 
@end


@interface FLZenfolioApiSoapReorderPhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioReorderPhotoSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioReorderPhotoSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

