//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapDeletePhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Deletes a photoset. <A href="/zf/help/api/ref/methods/deletephotoset">More...</A>
*/



@class FLZfDeletePhotoSet;
@class FLZfDeletePhotoSetResponse;

// --------------------------------------------------------------------
// FLZfApiSoapDeletePhotoSet
// --------------------------------------------------------------------
@interface FLZfApiSoapDeletePhotoSet : NSObject{ 
@private
	FLZfDeletePhotoSet* _input;
	FLZfDeletePhotoSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfDeletePhotoSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfDeletePhotoSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapDeletePhotoSet*) apiSoapDeletePhotoSet; 

@end

@interface FLZfApiSoapDeletePhotoSet (ValueProperties) 
@end


@interface FLZfApiSoapDeletePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfDeletePhotoSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfDeletePhotoSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

