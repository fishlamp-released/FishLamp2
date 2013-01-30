//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostDeletePhotoSet.h
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



@class FLZenfolioDeletePhotoSetHttpPostIn;
@class FLZenfolioDeletePhotoSetHttpPostOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostDeletePhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostDeletePhotoSet : NSObject{ 
@private
	FLZenfolioDeletePhotoSetHttpPostIn* _input;
	FLZenfolioDeletePhotoSetHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioDeletePhotoSetHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioDeletePhotoSetHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostDeletePhotoSet*) apiHttpPostDeletePhotoSet; 

@end

@interface FLZenfolioApiHttpPostDeletePhotoSet (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostDeletePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioDeletePhotoSetHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioDeletePhotoSetHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

