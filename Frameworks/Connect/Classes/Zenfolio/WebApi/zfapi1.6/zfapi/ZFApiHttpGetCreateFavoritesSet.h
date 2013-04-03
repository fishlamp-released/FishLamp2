//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetCreateFavoritesSet.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Creates a favorites set with the specified list of photos. <A href="/Zenfolio/help/api/ref/methods/createfavoritesset">More...</A>
*/



@class ZFCreateFavoritesSetHttpGetIn;

// --------------------------------------------------------------------
// ZFApiHttpGetCreateFavoritesSet
// --------------------------------------------------------------------
@interface ZFApiHttpGetCreateFavoritesSet : NSObject{ 
@private
	ZFCreateFavoritesSetHttpGetIn* _input;
	NSNumber* _output;
} 


@property (readwrite, retain, nonatomic) ZFCreateFavoritesSetHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSNumber* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetCreateFavoritesSet*) apiHttpGetCreateFavoritesSet; 

@end

@interface ZFApiHttpGetCreateFavoritesSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int outputValue;
@end


@interface ZFApiHttpGetCreateFavoritesSet (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFCreateFavoritesSetHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

