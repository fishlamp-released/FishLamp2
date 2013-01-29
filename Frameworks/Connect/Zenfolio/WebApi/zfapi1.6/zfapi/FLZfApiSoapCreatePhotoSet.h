//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapCreatePhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Creates a photoset. <A href="/zf/help/api/ref/methods/createphotoset">More...</A>
*/



@class FLZfCreatePhotoSet;
@class FLZfCreatePhotoSetResponse;

// --------------------------------------------------------------------
// FLZfApiSoapCreatePhotoSet
// --------------------------------------------------------------------
@interface FLZfApiSoapCreatePhotoSet : NSObject{ 
@private
	FLZfCreatePhotoSet* _input;
	FLZfCreatePhotoSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfCreatePhotoSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfCreatePhotoSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapCreatePhotoSet*) apiSoapCreatePhotoSet; 

@end

@interface FLZfApiSoapCreatePhotoSet (ValueProperties) 
@end


@interface FLZfApiSoapCreatePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfCreatePhotoSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfCreatePhotoSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

