//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostCreateFavoritesSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Creates a favorites set with the specified list of photos. <A href="/Zenfolio/help/api/ref/methods/createfavoritesset">More...</A>
*/



@class FLZenfolioCreateFavoritesSetHttpPostIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostCreateFavoritesSet
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostCreateFavoritesSet : NSObject{ 
@private
	FLZenfolioCreateFavoritesSetHttpPostIn* _input;
	NSNumber* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioCreateFavoritesSetHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSNumber* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostCreateFavoritesSet*) apiHttpPostCreateFavoritesSet; 

@end

@interface FLZenfolioApiHttpPostCreateFavoritesSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int outputValue;
@end


@interface FLZenfolioApiHttpPostCreateFavoritesSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioCreateFavoritesSetHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

