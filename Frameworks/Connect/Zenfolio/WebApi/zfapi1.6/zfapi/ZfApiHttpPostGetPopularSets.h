//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostGetPopularSets.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Retrieves photo sets in order of popularity (most viewed at the top). <A href="/zf/help/api/ref/methods/getpopularsets">More...</A>
*/



@class ZFGetPopularSetsHttpPostIn;
@class ZFPhotoSet;

// --------------------------------------------------------------------
// ZFApiHttpPostGetPopularSets
// --------------------------------------------------------------------
@interface ZFApiHttpPostGetPopularSets : NSObject{ 
@private
	ZFGetPopularSetsHttpPostIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetPopularSetsHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: ZFPhotoSet*, forKey: PhotoSet

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostGetPopularSets*) apiHttpPostGetPopularSets; 

@end

@interface ZFApiHttpPostGetPopularSets (ValueProperties) 
@end


@interface ZFApiHttpPostGetPopularSets (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetPopularSetsHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: ZFPhotoSet*, forKey: PhotoSet

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

