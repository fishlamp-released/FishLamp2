//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostSearchPhotoByCategory.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Searches photos by category id. <A href="/Zenfolio/help/api/ref/methods/searchphotobycategory">More...</A>
*/



@class FLZenfolioSearchPhotoByCategoryHttpPostIn;
@class FLZenfolioPhotoResult;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostSearchPhotoByCategory
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostSearchPhotoByCategory : NSObject{ 
@private
	FLZenfolioSearchPhotoByCategoryHttpPostIn* _input;
	FLZenfolioPhotoResult* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioSearchPhotoByCategoryHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZenfolioPhotoResult* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostSearchPhotoByCategory*) apiHttpPostSearchPhotoByCategory; 

@end

@interface FLZenfolioApiHttpPostSearchPhotoByCategory (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostSearchPhotoByCategory (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioSearchPhotoByCategoryHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZenfolioPhotoResult* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

