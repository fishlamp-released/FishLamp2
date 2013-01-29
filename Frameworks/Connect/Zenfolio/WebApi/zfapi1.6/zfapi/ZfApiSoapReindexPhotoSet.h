//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapReindexPhotoSet.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Reorders photoset elements. <A href="/zf/help/api/ref/methods/reindexphotoset">More...</A>
*/



@class ZFReindexPhotoSet;
@class ZFReindexPhotoSetResponse;

// --------------------------------------------------------------------
// ZFApiSoapReindexPhotoSet
// --------------------------------------------------------------------
@interface ZFApiSoapReindexPhotoSet : NSObject{ 
@private
	ZFReindexPhotoSet* _input;
	ZFReindexPhotoSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFReindexPhotoSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFReindexPhotoSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapReindexPhotoSet*) apiSoapReindexPhotoSet; 

@end

@interface ZFApiSoapReindexPhotoSet (ValueProperties) 
@end


@interface ZFApiSoapReindexPhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFReindexPhotoSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFReindexPhotoSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

