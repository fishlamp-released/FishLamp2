//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapDeletePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Deletes a photo. <A href="/Zenfolio/help/api/ref/methods/deletephoto">More...</A>
*/



@class FLZenfolioDeletePhoto;
@class FLZenfolioDeletePhotoResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapDeletePhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapDeletePhoto : NSObject{ 
@private
	FLZenfolioDeletePhoto* _input;
	FLZenfolioDeletePhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioDeletePhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioDeletePhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapDeletePhoto*) apiSoapDeletePhoto; 

@end

@interface FLZenfolioApiSoapDeletePhoto (ValueProperties) 
@end


@interface FLZenfolioApiSoapDeletePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioDeletePhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioDeletePhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

