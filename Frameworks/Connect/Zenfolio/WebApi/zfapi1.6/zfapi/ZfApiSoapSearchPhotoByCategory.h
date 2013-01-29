//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapSearchPhotoByCategory.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Searches photos by category id. <A href="/zf/help/api/ref/methods/searchphotobycategory">More...</A>
*/



@class ZFSearchPhotoByCategory;
@class ZFSearchPhotoByCategoryResponse;

// --------------------------------------------------------------------
// ZFApiSoapSearchPhotoByCategory
// --------------------------------------------------------------------
@interface ZFApiSoapSearchPhotoByCategory : NSObject{ 
@private
	ZFSearchPhotoByCategory* _input;
	ZFSearchPhotoByCategoryResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFSearchPhotoByCategory* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFSearchPhotoByCategoryResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapSearchPhotoByCategory*) apiSoapSearchPhotoByCategory; 

@end

@interface ZFApiSoapSearchPhotoByCategory (ValueProperties) 
@end


@interface ZFApiSoapSearchPhotoByCategory (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFSearchPhotoByCategory* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFSearchPhotoByCategoryResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

