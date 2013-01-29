//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostSearchPhotoByText.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Searches photos using full-text search. <A href="/zf/help/api/ref/methods/searchphotobytext">More...</A>
*/



@class FLZfSearchPhotoByTextHttpPostIn;
@class FLZfPhotoResult;

// --------------------------------------------------------------------
// FLZfApiHttpPostSearchPhotoByText
// --------------------------------------------------------------------
@interface FLZfApiHttpPostSearchPhotoByText : NSObject{ 
@private
	FLZfSearchPhotoByTextHttpPostIn* _input;
	FLZfPhotoResult* _output;
} 


@property (readwrite, retain, nonatomic) FLZfSearchPhotoByTextHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfPhotoResult* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostSearchPhotoByText*) apiHttpPostSearchPhotoByText; 

@end

@interface FLZfApiHttpPostSearchPhotoByText (ValueProperties) 
@end


@interface FLZfApiHttpPostSearchPhotoByText (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfSearchPhotoByTextHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfPhotoResult* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

