//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapDeletePhoto.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Deletes a photo. <A href="/zf/help/api/ref/methods/deletephoto">More...</A>
*/



@class FLZfDeletePhoto;
@class FLZfDeletePhotoResponse;

// --------------------------------------------------------------------
// FLZfApiSoapDeletePhoto
// --------------------------------------------------------------------
@interface FLZfApiSoapDeletePhoto : NSObject{ 
@private
	FLZfDeletePhoto* _input;
	FLZfDeletePhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfDeletePhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfDeletePhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapDeletePhoto*) apiSoapDeletePhoto; 

@end

@interface FLZfApiSoapDeletePhoto (ValueProperties) 
@end


@interface FLZfApiSoapDeletePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfDeletePhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfDeletePhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

