//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapShareFavoritesSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Shares a favorites set with the photographer. <A href="/zf/help/api/ref/methods/sharefavoritesset">More...</A>
*/



@class FLZfShareFavoritesSet;
@class FLZfShareFavoritesSetResponse;

// --------------------------------------------------------------------
// FLZfApiSoapShareFavoritesSet
// --------------------------------------------------------------------
@interface FLZfApiSoapShareFavoritesSet : NSObject{ 
@private
	FLZfShareFavoritesSet* _input;
	FLZfShareFavoritesSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfShareFavoritesSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfShareFavoritesSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapShareFavoritesSet*) apiSoapShareFavoritesSet; 

@end

@interface FLZfApiSoapShareFavoritesSet (ValueProperties) 
@end


@interface FLZfApiSoapShareFavoritesSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfShareFavoritesSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfShareFavoritesSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

