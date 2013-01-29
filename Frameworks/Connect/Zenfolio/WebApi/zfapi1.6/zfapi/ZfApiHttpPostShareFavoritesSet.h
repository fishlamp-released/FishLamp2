//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostShareFavoritesSet.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Shares a favorites set with the photographer. <A href="/zf/help/api/ref/methods/sharefavoritesset">More...</A>
*/



@class ZFShareFavoritesSetHttpPostIn;
@class ZFShareFavoritesSetHttpPostOut;

// --------------------------------------------------------------------
// ZFApiHttpPostShareFavoritesSet
// --------------------------------------------------------------------
@interface ZFApiHttpPostShareFavoritesSet : NSObject{ 
@private
	ZFShareFavoritesSetHttpPostIn* _input;
	ZFShareFavoritesSetHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFShareFavoritesSetHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFShareFavoritesSetHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostShareFavoritesSet*) apiHttpPostShareFavoritesSet; 

@end

@interface ZFApiHttpPostShareFavoritesSet (ValueProperties) 
@end


@interface ZFApiHttpPostShareFavoritesSet (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFShareFavoritesSetHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFShareFavoritesSetHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

