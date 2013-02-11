//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapCreatePhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Creates a photoset. <A href="/Zenfolio/help/api/ref/methods/createphotoset">More...</A>
*/



@class FLZenfolioCreatePhotoSet;
@class FLZenfolioCreatePhotoSetResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapCreatePhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapCreatePhotoSet : NSObject{ 
@private
	FLZenfolioCreatePhotoSet* _input;
	FLZenfolioCreatePhotoSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioCreatePhotoSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioCreatePhotoSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapCreatePhotoSet*) apiSoapCreatePhotoSet; 

@end

@interface FLZenfolioApiSoapCreatePhotoSet (ValueProperties) 
@end


@interface FLZenfolioApiSoapCreatePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioCreatePhotoSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioCreatePhotoSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

