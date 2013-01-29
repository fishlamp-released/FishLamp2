//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostLoadSharedFavoritesSets.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Loads favorites sets shared with with the current user. <A href="/zf/help/api/ref/methods/loadsharedfavoritessets">More...</A>
*/



@class FLZfLoadSharedFavoritesSetsHttpPostIn;
@class FLZfFavoritesSet;

// --------------------------------------------------------------------
// FLZfApiHttpPostLoadSharedFavoritesSets
// --------------------------------------------------------------------
@interface FLZfApiHttpPostLoadSharedFavoritesSets : NSObject{ 
@private
	FLZfLoadSharedFavoritesSetsHttpPostIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadSharedFavoritesSetsHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: FLZfFavoritesSet*, forKey: FavoritesSet

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostLoadSharedFavoritesSets*) apiHttpPostLoadSharedFavoritesSets; 

@end

@interface FLZfApiHttpPostLoadSharedFavoritesSets (ValueProperties) 
@end


@interface FLZfApiHttpPostLoadSharedFavoritesSets (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadSharedFavoritesSetsHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: FLZfFavoritesSet*, forKey: FavoritesSet

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

