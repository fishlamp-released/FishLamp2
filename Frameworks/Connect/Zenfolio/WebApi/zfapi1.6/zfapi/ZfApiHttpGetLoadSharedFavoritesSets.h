//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetLoadSharedFavoritesSets.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Loads favorites sets shared with with the current user. <A href="/zf/help/api/ref/methods/loadsharedfavoritessets">More...</A>
*/



@class ZFLoadSharedFavoritesSetsHttpGetIn;
@class ZFFavoritesSet;

// --------------------------------------------------------------------
// ZFApiHttpGetLoadSharedFavoritesSets
// --------------------------------------------------------------------
@interface ZFApiHttpGetLoadSharedFavoritesSets : NSObject{ 
@private
	ZFLoadSharedFavoritesSetsHttpGetIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadSharedFavoritesSetsHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: ZFFavoritesSet*, forKey: FavoritesSet

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetLoadSharedFavoritesSets*) apiHttpGetLoadSharedFavoritesSets; 

@end

@interface ZFApiHttpGetLoadSharedFavoritesSets (ValueProperties) 
@end


@interface ZFApiHttpGetLoadSharedFavoritesSets (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadSharedFavoritesSetsHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: ZFFavoritesSet*, forKey: FavoritesSet

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

