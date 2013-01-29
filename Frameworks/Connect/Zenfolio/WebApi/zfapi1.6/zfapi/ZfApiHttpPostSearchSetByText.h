//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostSearchSetByText.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Searches photo sets using fullt-text search. <A href="/zf/help/api/ref/methods/searchsetbytext">More...</A>
*/



@class ZFSearchSetByTextHttpPostIn;
@class ZFPhotoSetResult;

// --------------------------------------------------------------------
// ZFApiHttpPostSearchSetByText
// --------------------------------------------------------------------
@interface ZFApiHttpPostSearchSetByText : NSObject{ 
@private
	ZFSearchSetByTextHttpPostIn* _input;
	ZFPhotoSetResult* _output;
} 


@property (readwrite, retain, nonatomic) ZFSearchSetByTextHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFPhotoSetResult* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostSearchSetByText*) apiHttpPostSearchSetByText; 

@end

@interface ZFApiHttpPostSearchSetByText (ValueProperties) 
@end


@interface ZFApiHttpPostSearchSetByText (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFSearchSetByTextHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFPhotoSetResult* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

