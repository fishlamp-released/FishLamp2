//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapShareFavoritesSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Shares a favorites set with the photographer. <A href="/Zenfolio/help/api/ref/methods/sharefavoritesset">More...</A>
*/



@class FLZenfolioShareFavoritesSet;
@class FLZenfolioShareFavoritesSetResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapShareFavoritesSet
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapShareFavoritesSet : NSObject{ 
@private
	FLZenfolioShareFavoritesSet* _input;
	FLZenfolioShareFavoritesSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioShareFavoritesSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioShareFavoritesSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapShareFavoritesSet*) apiSoapShareFavoritesSet; 

@end

@interface FLZenfolioApiSoapShareFavoritesSet (ValueProperties) 
@end


@interface FLZenfolioApiSoapShareFavoritesSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioShareFavoritesSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioShareFavoritesSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

