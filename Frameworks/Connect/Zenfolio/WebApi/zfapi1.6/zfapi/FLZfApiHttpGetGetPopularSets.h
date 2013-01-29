//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpGetGetPopularSets.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Retrieves photo sets in order of popularity (most viewed at the top). <A href="/zf/help/api/ref/methods/getpopularsets">More...</A>
*/



@class FLZfGetPopularSetsHttpGetIn;
@class FLZfPhotoSet;

// --------------------------------------------------------------------
// FLZfApiHttpGetGetPopularSets
// --------------------------------------------------------------------
@interface FLZfApiHttpGetGetPopularSets : NSObject{ 
@private
	FLZfGetPopularSetsHttpGetIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) FLZfGetPopularSetsHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: FLZfPhotoSet*, forKey: PhotoSet

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpGetGetPopularSets*) apiHttpGetGetPopularSets; 

@end

@interface FLZfApiHttpGetGetPopularSets (ValueProperties) 
@end


@interface FLZfApiHttpGetGetPopularSets (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfGetPopularSetsHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: FLZfPhotoSet*, forKey: PhotoSet

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

