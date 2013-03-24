//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetSearchPhotoByCategory.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Searches photos by category id. <A href="/Zenfolio/help/api/ref/methods/searchphotobycategory">More...</A>
*/



@class ZFSearchPhotoByCategoryHttpGetIn;
@class ZFPhotoResult;

// --------------------------------------------------------------------
// ZFApiHttpGetSearchPhotoByCategory
// --------------------------------------------------------------------
@interface ZFApiHttpGetSearchPhotoByCategory : NSObject{ 
@private
	ZFSearchPhotoByCategoryHttpGetIn* _input;
	ZFPhotoResult* _output;
} 


@property (readwrite, retain, nonatomic) ZFSearchPhotoByCategoryHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFPhotoResult* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetSearchPhotoByCategory*) apiHttpGetSearchPhotoByCategory; 

@end

@interface ZFApiHttpGetSearchPhotoByCategory (ValueProperties) 
@end


@interface ZFApiHttpGetSearchPhotoByCategory (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFSearchPhotoByCategoryHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFPhotoResult* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

