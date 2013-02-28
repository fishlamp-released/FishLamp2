//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetLoadSharedFavoritesSets.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads favorites sets shared with with the current user. <A href="/Zenfolio/help/api/ref/methods/loadsharedfavoritessets">More...</A>
*/



@class FLZenfolioLoadSharedFavoritesSetsHttpGetIn;
@class FLZenfolioFavoritesSet;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetLoadSharedFavoritesSets
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetLoadSharedFavoritesSets : NSObject{ 
@private
	FLZenfolioLoadSharedFavoritesSetsHttpGetIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioLoadSharedFavoritesSetsHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: FLZenfolioFavoritesSet*, forKey: FavoritesSet

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetLoadSharedFavoritesSets*) apiHttpGetLoadSharedFavoritesSets; 

@end

@interface FLZenfolioApiHttpGetLoadSharedFavoritesSets (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetLoadSharedFavoritesSets (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioLoadSharedFavoritesSetsHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: FLZenfolioFavoritesSet*, forKey: FavoritesSet

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end
