//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapDeletePhotoSet.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Deletes a photoset. <A href="/zf/help/api/ref/methods/deletephotoset">More...</A>
*/



@class ZFDeletePhotoSet;
@class ZFDeletePhotoSetResponse;

// --------------------------------------------------------------------
// ZFApiSoapDeletePhotoSet
// --------------------------------------------------------------------
@interface ZFApiSoapDeletePhotoSet : NSObject{ 
@private
	ZFDeletePhotoSet* _input;
	ZFDeletePhotoSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFDeletePhotoSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFDeletePhotoSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapDeletePhotoSet*) apiSoapDeletePhotoSet; 

@end

@interface ZFApiSoapDeletePhotoSet (ValueProperties) 
@end


@interface ZFApiSoapDeletePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFDeletePhotoSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFDeletePhotoSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

