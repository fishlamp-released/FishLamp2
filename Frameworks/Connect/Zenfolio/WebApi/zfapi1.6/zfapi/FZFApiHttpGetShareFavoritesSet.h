//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetShareFavoritesSet.h
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



@class FLZenfolioShareFavoritesSetHttpGetIn;
@class FLZenfolioShareFavoritesSetHttpGetOut;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetShareFavoritesSet
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetShareFavoritesSet : NSObject{ 
@private
	FLZenfolioShareFavoritesSetHttpGetIn* _input;
	FLZenfolioShareFavoritesSetHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioShareFavoritesSetHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioShareFavoritesSetHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetShareFavoritesSet*) apiHttpGetShareFavoritesSet; 

@end

@interface FLZenfolioApiHttpGetShareFavoritesSet (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetShareFavoritesSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioShareFavoritesSetHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioShareFavoritesSetHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

