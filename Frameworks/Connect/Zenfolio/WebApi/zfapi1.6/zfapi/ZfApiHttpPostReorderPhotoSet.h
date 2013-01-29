//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostReorderPhotoSet.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Reorders photoset elements based on the specified sort order. <A href="/zf/help/api/ref/methods/reorderphotoset">More...</A>
*/



@class ZFReorderPhotoSetHttpPostIn;
@class ZFReorderPhotoSetHttpPostOut;

// --------------------------------------------------------------------
// ZFApiHttpPostReorderPhotoSet
// --------------------------------------------------------------------
@interface ZFApiHttpPostReorderPhotoSet : NSObject{ 
@private
	ZFReorderPhotoSetHttpPostIn* _input;
	ZFReorderPhotoSetHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFReorderPhotoSetHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFReorderPhotoSetHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostReorderPhotoSet*) apiHttpPostReorderPhotoSet; 

@end

@interface ZFApiHttpPostReorderPhotoSet (ValueProperties) 
@end


@interface ZFApiHttpPostReorderPhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFReorderPhotoSetHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFReorderPhotoSetHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

