//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapDeletePhotoSet.h
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



@class FLZenfolioDeletePhotoSet;
@class FLZenfolioDeletePhotoSetResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapDeletePhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapDeletePhotoSet : NSObject{ 
@private
	FLZenfolioDeletePhotoSet* _input;
	FLZenfolioDeletePhotoSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioDeletePhotoSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioDeletePhotoSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapDeletePhotoSet*) apiSoapDeletePhotoSet; 

@end

@interface FLZenfolioApiSoapDeletePhotoSet (ValueProperties) 
@end


@interface FLZenfolioApiSoapDeletePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioDeletePhotoSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioDeletePhotoSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

