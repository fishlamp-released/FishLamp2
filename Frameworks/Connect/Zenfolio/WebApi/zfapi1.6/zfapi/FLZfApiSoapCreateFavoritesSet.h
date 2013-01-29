//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapCreateFavoritesSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Creates a favorites set with the specified list of photos. <A href="/zf/help/api/ref/methods/createfavoritesset">More...</A>
*/



@class FLZfCreateFavoritesSet;
@class FLZfCreateFavoritesSetResponse;

// --------------------------------------------------------------------
// FLZfApiSoapCreateFavoritesSet
// --------------------------------------------------------------------
@interface FLZfApiSoapCreateFavoritesSet : NSObject{ 
@private
	FLZfCreateFavoritesSet* _input;
	FLZfCreateFavoritesSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfCreateFavoritesSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfCreateFavoritesSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapCreateFavoritesSet*) apiSoapCreateFavoritesSet; 

@end

@interface FLZfApiSoapCreateFavoritesSet (ValueProperties) 
@end


@interface FLZfApiSoapCreateFavoritesSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfCreateFavoritesSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfCreateFavoritesSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

