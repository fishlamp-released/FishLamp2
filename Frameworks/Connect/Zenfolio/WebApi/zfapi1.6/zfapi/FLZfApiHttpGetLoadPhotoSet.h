//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetLoadPhotoSet.h
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



@class FLZfLoadPhotoSetHttpGetIn;
@class FLZfPhotoSet;

// --------------------------------------------------------------------
// FLZfApiHttpGetLoadPhotoSet
// --------------------------------------------------------------------
@interface FLZfApiHttpGetLoadPhotoSet : NSObject{ 
@private
	FLZfLoadPhotoSetHttpGetIn* _input;
	FLZfPhotoSet* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadPhotoSetHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfPhotoSet* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetLoadPhotoSet*) apiHttpGetLoadPhotoSet; 

@end

@interface FLZfApiHttpGetLoadPhotoSet (ValueProperties) 
@end


@interface FLZfApiHttpGetLoadPhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadPhotoSetHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfPhotoSet* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

