//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapSetGroupTitlePhoto.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Sets a title (cover) photograph for a group. <A href="/Zenfolio/help/api/ref/methods/setgrouptitlephoto">More...</A>
*/



@class FLZenfolioSetGroupTitlePhoto;
@class FLZenfolioSetGroupTitlePhotoResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapSetGroupTitlePhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapSetGroupTitlePhoto : NSObject{ 
@private
	FLZenfolioSetGroupTitlePhoto* _input;
	FLZenfolioSetGroupTitlePhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioSetGroupTitlePhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioSetGroupTitlePhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapSetGroupTitlePhoto*) apiSoapSetGroupTitlePhoto; 

@end

@interface FLZenfolioApiSoapSetGroupTitlePhoto (ValueProperties) 
@end


@interface FLZenfolioApiSoapSetGroupTitlePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioSetGroupTitlePhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioSetGroupTitlePhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

