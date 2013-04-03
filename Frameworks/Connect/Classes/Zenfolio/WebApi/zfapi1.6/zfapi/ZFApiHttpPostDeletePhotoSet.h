//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostDeletePhotoSet.h
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



@class ZFDeletePhotoSetHttpPostIn;
@class ZFDeletePhotoSetHttpPostOut;

// --------------------------------------------------------------------
// ZFApiHttpPostDeletePhotoSet
// --------------------------------------------------------------------
@interface ZFApiHttpPostDeletePhotoSet : NSObject{ 
@private
	ZFDeletePhotoSetHttpPostIn* _input;
	ZFDeletePhotoSetHttpPostOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFDeletePhotoSetHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFDeletePhotoSetHttpPostOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostDeletePhotoSet*) apiHttpPostDeletePhotoSet; 

@end

@interface ZFApiHttpPostDeletePhotoSet (ValueProperties) 
@end


@interface ZFApiHttpPostDeletePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFDeletePhotoSetHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFDeletePhotoSetHttpPostOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

