//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostSearchPhotoByCategory.h
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



@class ZFSearchPhotoByCategoryHttpPostIn;
@class ZFPhotoResult;

// --------------------------------------------------------------------
// ZFApiHttpPostSearchPhotoByCategory
// --------------------------------------------------------------------
@interface ZFApiHttpPostSearchPhotoByCategory : NSObject{ 
@private
	ZFSearchPhotoByCategoryHttpPostIn* _input;
	ZFPhotoResult* _output;
} 


@property (readwrite, retain, nonatomic) ZFSearchPhotoByCategoryHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFPhotoResult* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostSearchPhotoByCategory*) apiHttpPostSearchPhotoByCategory; 

@end

@interface ZFApiHttpPostSearchPhotoByCategory (ValueProperties) 
@end


@interface ZFApiHttpPostSearchPhotoByCategory (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFSearchPhotoByCategoryHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFPhotoResult* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end
