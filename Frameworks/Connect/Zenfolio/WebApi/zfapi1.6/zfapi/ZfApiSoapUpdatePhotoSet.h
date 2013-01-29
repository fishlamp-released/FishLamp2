//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapUpdatePhotoSet.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Updates a photoset. <A href="/zf/help/api/ref/methods/updatephotoset">More...</A>
*/



@class ZFUpdatePhotoSet;
@class ZFUpdatePhotoSetResponse;

// --------------------------------------------------------------------
// ZFApiSoapUpdatePhotoSet
// --------------------------------------------------------------------
@interface ZFApiSoapUpdatePhotoSet : NSObject{ 
@private
	ZFUpdatePhotoSet* _input;
	ZFUpdatePhotoSetResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFUpdatePhotoSet* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFUpdatePhotoSetResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapUpdatePhotoSet*) apiSoapUpdatePhotoSet; 

@end

@interface ZFApiSoapUpdatePhotoSet (ValueProperties) 
@end


@interface ZFApiSoapUpdatePhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFUpdatePhotoSet* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFUpdatePhotoSetResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

