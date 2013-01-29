//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapLoadPhotoSet.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Loads the specified photoset. <A href="/zf/help/api/ref/methods/loadphotoset">More...</A>
*/



@class FLZfLoadPhotoSet;
@class FLZfLoadPhotoSetResponse;

// --------------------------------------------------------------------
// FLZfApiSoapLoadPhotoSet
// --------------------------------------------------------------------
@interface FLZfApiSoapLoadPhotoSet : NSObject{ 
@private
	FLZfLoadPhotoSet* _input;
	FLZfLoadPhotoSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadPhotoSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfLoadPhotoSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapLoadPhotoSet*) apiSoapLoadPhotoSet; 

@end

@interface FLZfApiSoapLoadPhotoSet (ValueProperties) 
@end


@interface FLZfApiSoapLoadPhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadPhotoSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfLoadPhotoSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

