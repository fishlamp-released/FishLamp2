//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapSearchPhotoByCategory.h
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



@class FLZfSearchPhotoByCategory;
@class FLZfSearchPhotoByCategoryResponse;

// --------------------------------------------------------------------
// FLZfApiSoapSearchPhotoByCategory
// --------------------------------------------------------------------
@interface FLZfApiSoapSearchPhotoByCategory : NSObject{ 
@private
	FLZfSearchPhotoByCategory* _input;
	FLZfSearchPhotoByCategoryResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfSearchPhotoByCategory* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfSearchPhotoByCategoryResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapSearchPhotoByCategory*) apiSoapSearchPhotoByCategory; 

@end

@interface FLZfApiSoapSearchPhotoByCategory (ValueProperties) 
@end


@interface FLZfApiSoapSearchPhotoByCategory (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfSearchPhotoByCategory* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfSearchPhotoByCategoryResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

