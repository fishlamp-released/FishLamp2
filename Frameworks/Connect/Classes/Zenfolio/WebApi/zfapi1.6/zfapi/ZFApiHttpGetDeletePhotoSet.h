//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetDeletePhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Deletes a photoset. <A href="/Zenfolio/help/api/ref/methods/deletephotoset">More...</A>
*/



@class ZFDeletePhotoSetHttpGetIn;
@class ZFDeletePhotoSetHttpGetOut;

// --------------------------------------------------------------------
// ZFApiHttpGetDeletePhotoSet
// --------------------------------------------------------------------
@interface ZFApiHttpGetDeletePhotoSet : NSObject{ 
@private
	ZFDeletePhotoSetHttpGetIn* _input;
	ZFDeletePhotoSetHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFDeletePhotoSetHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFDeletePhotoSetHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetDeletePhotoSet*) apiHttpGetDeletePhotoSet; 

@end

@interface ZFApiHttpGetDeletePhotoSet (ValueProperties) 
@end


@interface ZFApiHttpGetDeletePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFDeletePhotoSetHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFDeletePhotoSetHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

