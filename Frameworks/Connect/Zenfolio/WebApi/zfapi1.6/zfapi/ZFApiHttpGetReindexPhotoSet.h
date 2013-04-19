//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetReindexPhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Reorders photoset elements. <A href="/Zenfolio/help/api/ref/methods/reindexphotoset">More...</A>
*/



@class ZFReindexPhotoSetHttpGetIn;
@class ZFReindexPhotoSetHttpGetOut;

// --------------------------------------------------------------------
// ZFApiHttpGetReindexPhotoSet
// --------------------------------------------------------------------
@interface ZFApiHttpGetReindexPhotoSet : NSObject{ 
@private
	ZFReindexPhotoSetHttpGetIn* _input;
	ZFReindexPhotoSetHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFReindexPhotoSetHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFReindexPhotoSetHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetReindexPhotoSet*) apiHttpGetReindexPhotoSet; 

@end

@interface ZFApiHttpGetReindexPhotoSet (ValueProperties) 
@end


@interface ZFApiHttpGetReindexPhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFReindexPhotoSetHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFReindexPhotoSetHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end
