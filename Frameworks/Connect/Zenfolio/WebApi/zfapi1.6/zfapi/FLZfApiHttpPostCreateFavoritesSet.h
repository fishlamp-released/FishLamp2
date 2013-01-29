//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostCreateFavoritesSet.h
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



@class FLZfCreateFavoritesSetHttpPostIn;

// --------------------------------------------------------------------
// FLZfApiHttpPostCreateFavoritesSet
// --------------------------------------------------------------------
@interface FLZfApiHttpPostCreateFavoritesSet : NSObject{ 
@private
	FLZfCreateFavoritesSetHttpPostIn* _input;
	NSNumber* _output;
} 


@property (readwrite, retain, nonatomic) FLZfCreateFavoritesSetHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSNumber* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostCreateFavoritesSet*) apiHttpPostCreateFavoritesSet; 

@end

@interface FLZfApiHttpPostCreateFavoritesSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int outputValue;
@end


@interface FLZfApiHttpPostCreateFavoritesSet (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfCreateFavoritesSetHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

