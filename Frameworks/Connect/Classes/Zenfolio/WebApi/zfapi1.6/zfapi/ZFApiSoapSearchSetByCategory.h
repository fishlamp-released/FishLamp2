//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapSearchSetByCategory.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Searches photo sets by category id. <A href="/Zenfolio/help/api/ref/methods/searchsetbycategory">More...</A>
*/



@class ZFSearchSetByCategory;
@class ZFSearchSetByCategoryResponse;

// --------------------------------------------------------------------
// ZFApiSoapSearchSetByCategory
// --------------------------------------------------------------------
@interface ZFApiSoapSearchSetByCategory : NSObject{ 
@private
	ZFSearchSetByCategory* _input;
	ZFSearchSetByCategoryResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFSearchSetByCategory* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFSearchSetByCategoryResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapSearchSetByCategory*) apiSoapSearchSetByCategory; 

@end

@interface ZFApiSoapSearchSetByCategory (ValueProperties) 
@end


@interface ZFApiSoapSearchSetByCategory (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFSearchSetByCategory* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFSearchSetByCategoryResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

