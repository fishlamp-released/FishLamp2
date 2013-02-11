//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetSetGroupTitlePhoto.h
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



@class FLZenfolioSetGroupTitlePhotoHttpGetIn;
@class FLZenfolioSetGroupTitlePhotoHttpGetOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetSetGroupTitlePhoto
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetSetGroupTitlePhoto : NSObject{ 
@private
	FLZenfolioSetGroupTitlePhotoHttpGetIn* _input;
	FLZenfolioSetGroupTitlePhotoHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioSetGroupTitlePhotoHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioSetGroupTitlePhotoHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetSetGroupTitlePhoto*) apiHttpGetSetGroupTitlePhoto; 

@end

@interface FLZenfolioApiHttpGetSetGroupTitlePhoto (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetSetGroupTitlePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioSetGroupTitlePhotoHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioSetGroupTitlePhotoHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

