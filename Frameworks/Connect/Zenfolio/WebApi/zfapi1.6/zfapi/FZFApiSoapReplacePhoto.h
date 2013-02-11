//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapReplacePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Replaces a photo with other existing photo. <A href="/Zenfolio/help/api/ref/methods/replacephoto">More...</A>
*/



@class FLZenfolioReplacePhoto;
@class FLZenfolioReplacePhotoResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapReplacePhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapReplacePhoto : NSObject{ 
@private
	FLZenfolioReplacePhoto* _input;
	FLZenfolioReplacePhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioReplacePhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioReplacePhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapReplacePhoto*) apiSoapReplacePhoto; 

@end

@interface FLZenfolioApiSoapReplacePhoto (ValueProperties) 
@end


@interface FLZenfolioApiSoapReplacePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioReplacePhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioReplacePhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

