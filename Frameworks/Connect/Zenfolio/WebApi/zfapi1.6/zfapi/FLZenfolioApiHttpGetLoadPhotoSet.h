//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetLoadPhotoSet.h
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



@class FLZenfolioLoadPhotoSetHttpGetIn;
@class FLZenfolioPhotoSet;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetLoadPhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetLoadPhotoSet : NSObject{ 
@private
	FLZenfolioLoadPhotoSetHttpGetIn* _input;
	FLZenfolioPhotoSet* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioLoadPhotoSetHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioPhotoSet* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetLoadPhotoSet*) apiHttpGetLoadPhotoSet; 

@end

@interface FLZenfolioApiHttpGetLoadPhotoSet (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetLoadPhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioLoadPhotoSetHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioPhotoSet* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

