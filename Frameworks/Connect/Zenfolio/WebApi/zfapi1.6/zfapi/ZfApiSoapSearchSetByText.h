//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapSearchSetByText.h
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



@class ZFSearchSetByText;
@class ZFSearchSetByTextResponse;

// --------------------------------------------------------------------
// ZFApiSoapSearchSetByText
// --------------------------------------------------------------------
@interface ZFApiSoapSearchSetByText : NSObject{ 
@private
	ZFSearchSetByText* _input;
	ZFSearchSetByTextResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFSearchSetByText* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFSearchSetByTextResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapSearchSetByText*) apiSoapSearchSetByText; 

@end

@interface ZFApiSoapSearchSetByText (ValueProperties) 
@end


@interface ZFApiSoapSearchSetByText (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFSearchSetByText* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFSearchSetByTextResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

