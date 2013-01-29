//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiHttpPostSearchPhotoByCategory.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Searches photos by category id. <A href="/zf/help/api/ref/methods/searchphotobycategory">More...</A>
*/



@class FLZfSearchPhotoByCategoryHttpPostIn;
@class FLZfPhotoResult;

// --------------------------------------------------------------------
// FLZfApiHttpPostSearchPhotoByCategory
// --------------------------------------------------------------------
@interface FLZfApiHttpPostSearchPhotoByCategory : NSObject{ 
@private
	FLZfSearchPhotoByCategoryHttpPostIn* _input;
	FLZfPhotoResult* _output;
} 


@property (readwrite, retain, nonatomic) FLZfSearchPhotoByCategoryHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfPhotoResult* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiHttpPostSearchPhotoByCategory*) apiHttpPostSearchPhotoByCategory; 

@end

@interface FLZfApiHttpPostSearchPhotoByCategory (ValueProperties) 
@end


@interface FLZfApiHttpPostSearchPhotoByCategory (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfSearchPhotoByCategoryHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfPhotoResult* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

