//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapSetGroupTitlePhoto.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Sets a title (cover) photograph for a group. <A href="/zf/help/api/ref/methods/setgrouptitlephoto">More...</A>
*/



@class FLZfSetGroupTitlePhoto;
@class FLZfSetGroupTitlePhotoResponse;

// --------------------------------------------------------------------
// FLZfApiSoapSetGroupTitlePhoto
// --------------------------------------------------------------------
@interface FLZfApiSoapSetGroupTitlePhoto : NSObject{ 
@private
	FLZfSetGroupTitlePhoto* _input;
	FLZfSetGroupTitlePhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfSetGroupTitlePhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfSetGroupTitlePhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapSetGroupTitlePhoto*) apiSoapSetGroupTitlePhoto; 

@end

@interface FLZfApiSoapSetGroupTitlePhoto (ValueProperties) 
@end


@interface FLZfApiSoapSetGroupTitlePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfSetGroupTitlePhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfSetGroupTitlePhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

