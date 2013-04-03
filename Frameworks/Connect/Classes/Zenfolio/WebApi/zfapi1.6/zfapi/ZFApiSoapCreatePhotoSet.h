//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapCreatePhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Creates a photoset. <A href="/Zenfolio/help/api/ref/methods/createphotoset">More...</A>
*/



@class ZFCreatePhotoSet;
@class ZFCreatePhotoSetResponse;

// --------------------------------------------------------------------
// ZFApiSoapCreatePhotoSet
// --------------------------------------------------------------------
@interface ZFApiSoapCreatePhotoSet : NSObject{ 
@private
	ZFCreatePhotoSet* _input;
	ZFCreatePhotoSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFCreatePhotoSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFCreatePhotoSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapCreatePhotoSet*) apiSoapCreatePhotoSet; 

@end

@interface ZFApiSoapCreatePhotoSet (ValueProperties) 
@end


@interface ZFApiSoapCreatePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFCreatePhotoSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFCreatePhotoSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

