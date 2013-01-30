//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiSoapCreateFavoritesSet.h
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



@class FLZenfolioCreateFavoritesSet;
@class FLZenfolioCreateFavoritesSetResponse;

// --------------------------------------------------------------------
// FLZenfolioApiSoapCreateFavoritesSet
// --------------------------------------------------------------------
@interface FLZenfolioApiSoapCreateFavoritesSet : NSObject{ 
@private
	FLZenfolioCreateFavoritesSet* _input;
	FLZenfolioCreateFavoritesSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioCreateFavoritesSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioCreateFavoritesSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiSoapCreateFavoritesSet*) apiSoapCreateFavoritesSet; 

@end

@interface FLZenfolioApiSoapCreateFavoritesSet (ValueProperties) 
@end


@interface FLZenfolioApiSoapCreateFavoritesSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioCreateFavoritesSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioCreateFavoritesSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

