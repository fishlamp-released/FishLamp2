//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapLoadPhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads the specified photoset. <A href="/Zenfolio/help/api/ref/methods/loadphotoset">More...</A>
*/



@class FLZenfolioLoadPhotoSet;
@class FLZenfolioLoadPhotoSetResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapLoadPhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapLoadPhotoSet : NSObject{ 
@private
	FLZenfolioLoadPhotoSet* _input;
	FLZenfolioLoadPhotoSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioLoadPhotoSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioLoadPhotoSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapLoadPhotoSet*) apiSoapLoadPhotoSet; 

@end

@interface FLZenfolioApiSoapLoadPhotoSet (ValueProperties) 
@end


@interface FLZenfolioApiSoapLoadPhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioLoadPhotoSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioLoadPhotoSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

