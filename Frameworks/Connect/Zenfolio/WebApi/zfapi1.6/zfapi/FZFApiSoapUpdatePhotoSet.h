//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapUpdatePhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Updates a photoset. <A href="/Zenfolio/help/api/ref/methods/updatephotoset">More...</A>
*/



@class FLZenfolioUpdatePhotoSet;
@class FLZenfolioUpdatePhotoSetResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapUpdatePhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapUpdatePhotoSet : NSObject{ 
@private
	FLZenfolioUpdatePhotoSet* _input;
	FLZenfolioUpdatePhotoSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioUpdatePhotoSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioUpdatePhotoSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapUpdatePhotoSet*) apiSoapUpdatePhotoSet; 

@end

@interface FLZenfolioApiSoapUpdatePhotoSet (ValueProperties) 
@end


@interface FLZenfolioApiSoapUpdatePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioUpdatePhotoSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioUpdatePhotoSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

