//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapSetGroupTitlePhoto.h
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



@class ZFSetGroupTitlePhoto;
@class ZFSetGroupTitlePhotoResponse;

// --------------------------------------------------------------------
// ZFApiSoapSetGroupTitlePhoto
// --------------------------------------------------------------------
@interface ZFApiSoapSetGroupTitlePhoto : NSObject{ 
@private
	ZFSetGroupTitlePhoto* _input;
	ZFSetGroupTitlePhotoResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFSetGroupTitlePhoto* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFSetGroupTitlePhotoResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapSetGroupTitlePhoto*) apiSoapSetGroupTitlePhoto; 

@end

@interface ZFApiSoapSetGroupTitlePhoto (ValueProperties) 
@end


@interface ZFApiSoapSetGroupTitlePhoto (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFSetGroupTitlePhoto* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFSetGroupTitlePhotoResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

