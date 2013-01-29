//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetSetGroupTitlePhoto.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Sets a title (cover) photograph for a group. <A href="/zf/help/api/ref/methods/setgrouptitlephoto">More...</A>
*/



@class ZFSetGroupTitlePhotoHttpGetIn;
@class ZFSetGroupTitlePhotoHttpGetOut;

// --------------------------------------------------------------------
// ZFApiHttpGetSetGroupTitlePhoto
// --------------------------------------------------------------------
@interface ZFApiHttpGetSetGroupTitlePhoto : NSObject{ 
@private
	ZFSetGroupTitlePhotoHttpGetIn* _input;
	ZFSetGroupTitlePhotoHttpGetOut* _output;
} 


@property (readwrite, retain, nonatomic) ZFSetGroupTitlePhotoHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFSetGroupTitlePhotoHttpGetOut* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetSetGroupTitlePhoto*) apiHttpGetSetGroupTitlePhoto; 

@end

@interface ZFApiHttpGetSetGroupTitlePhoto (ValueProperties) 
@end


@interface ZFApiHttpGetSetGroupTitlePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFSetGroupTitlePhotoHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFSetGroupTitlePhotoHttpGetOut* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

