//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapCreateFavoritesSet.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Creates a favorites set with the specified list of photos. <A href="/zf/help/api/ref/methods/createfavoritesset">More...</A>
*/



@class ZFCreateFavoritesSet;
@class ZFCreateFavoritesSetResponse;

// --------------------------------------------------------------------
// ZFApiSoapCreateFavoritesSet
// --------------------------------------------------------------------
@interface ZFApiSoapCreateFavoritesSet : NSObject{ 
@private
	ZFCreateFavoritesSet* _input;
	ZFCreateFavoritesSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFCreateFavoritesSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFCreateFavoritesSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapCreateFavoritesSet*) apiSoapCreateFavoritesSet; 

@end

@interface ZFApiSoapCreateFavoritesSet (ValueProperties) 
@end


@interface ZFApiSoapCreateFavoritesSet (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFCreateFavoritesSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFCreateFavoritesSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

