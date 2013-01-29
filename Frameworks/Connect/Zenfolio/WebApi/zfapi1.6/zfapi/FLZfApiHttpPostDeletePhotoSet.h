//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostDeletePhotoSet.h
//	Project: myZenfolio WebAPI
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



@class FLZfDeletePhotoSetHttpPostIn;
@class FLZfDeletePhotoSetHttpPostOut;

// --------------------------------------------------------------------
// FLZfApiHttpPostDeletePhotoSet
// --------------------------------------------------------------------
@interface FLZfApiHttpPostDeletePhotoSet : NSObject{ 
@private
	FLZfDeletePhotoSetHttpPostIn* _input;
	FLZfDeletePhotoSetHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZfDeletePhotoSetHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfDeletePhotoSetHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostDeletePhotoSet*) apiHttpPostDeletePhotoSet; 

@end

@interface FLZfApiHttpPostDeletePhotoSet (ValueProperties) 
@end


@interface FLZfApiHttpPostDeletePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfDeletePhotoSetHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfDeletePhotoSetHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

