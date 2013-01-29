//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostLoadPhotoSet.h
//	Project: FishLamp WebAPI
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



@class FLZfLoadPhotoSetHttpPostIn;
@class FLZfPhotoSet;

// --------------------------------------------------------------------
// FLZfApiHttpPostLoadPhotoSet
// --------------------------------------------------------------------
@interface FLZfApiHttpPostLoadPhotoSet : NSObject{ 
@private
	FLZfLoadPhotoSetHttpPostIn* _input;
	FLZfPhotoSet* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadPhotoSetHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfPhotoSet* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostLoadPhotoSet*) apiHttpPostLoadPhotoSet; 

@end

@interface FLZfApiHttpPostLoadPhotoSet (ValueProperties) 
@end


@interface FLZfApiHttpPostLoadPhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadPhotoSetHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfPhotoSet* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

