//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostSearchPhotoByText.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Searches photos using full-text search. <A href="/zf/help/api/ref/methods/searchphotobytext">More...</A>
*/



@class ZFSearchPhotoByTextHttpPostIn;
@class ZFPhotoResult;

// --------------------------------------------------------------------
// ZFApiHttpPostSearchPhotoByText
// --------------------------------------------------------------------
@interface ZFApiHttpPostSearchPhotoByText : NSObject{ 
@private
	ZFSearchPhotoByTextHttpPostIn* _input;
	ZFPhotoResult* _output;
} 


@property (readwrite, retain, nonatomic) ZFSearchPhotoByTextHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFPhotoResult* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostSearchPhotoByText*) apiHttpPostSearchPhotoByText; 

@end

@interface ZFApiHttpPostSearchPhotoByText (ValueProperties) 
@end


@interface ZFApiHttpPostSearchPhotoByText (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFSearchPhotoByTextHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFPhotoResult* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

