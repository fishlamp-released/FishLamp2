//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapLoadSharedFavoritesSets.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads favorites sets shared with with the current user. <A href="/Zenfolio/help/api/ref/methods/loadsharedfavoritessets">More...</A>
*/



@class ZFLoadSharedFavoritesSets;
@class ZFLoadSharedFavoritesSetsResponse;

// --------------------------------------------------------------------
// ZFApiSoapLoadSharedFavoritesSets
// --------------------------------------------------------------------
@interface ZFApiSoapLoadSharedFavoritesSets : NSObject{ 
@private
	ZFLoadSharedFavoritesSets* _input;
	ZFLoadSharedFavoritesSetsResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadSharedFavoritesSets* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFLoadSharedFavoritesSetsResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapLoadSharedFavoritesSets*) apiSoapLoadSharedFavoritesSets; 

@end

@interface ZFApiSoapLoadSharedFavoritesSets (ValueProperties) 
@end


@interface ZFApiSoapLoadSharedFavoritesSets (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadSharedFavoritesSets* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFLoadSharedFavoritesSetsResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end
