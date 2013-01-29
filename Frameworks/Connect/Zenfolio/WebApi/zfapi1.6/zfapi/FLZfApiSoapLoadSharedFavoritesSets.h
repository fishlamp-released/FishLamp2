//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapLoadSharedFavoritesSets.h
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



@class FLZfLoadSharedFavoritesSets;
@class FLZfLoadSharedFavoritesSetsResponse;

// --------------------------------------------------------------------
// FLZfApiSoapLoadSharedFavoritesSets
// --------------------------------------------------------------------
@interface FLZfApiSoapLoadSharedFavoritesSets : NSObject{ 
@private
	FLZfLoadSharedFavoritesSets* _input;
	FLZfLoadSharedFavoritesSetsResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfLoadSharedFavoritesSets* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfLoadSharedFavoritesSetsResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapLoadSharedFavoritesSets*) apiSoapLoadSharedFavoritesSets; 

@end

@interface FLZfApiSoapLoadSharedFavoritesSets (ValueProperties) 
@end


@interface FLZfApiSoapLoadSharedFavoritesSets (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfLoadSharedFavoritesSets* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfLoadSharedFavoritesSetsResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

