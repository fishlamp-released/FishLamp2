//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetLoadPhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Loads the specified photoset. <A href="/Zenfolio/help/api/ref/methods/loadphotoset">More...</A>
*/



@class ZFLoadPhotoSetHttpGetIn;
@class ZFPhotoSet;

// --------------------------------------------------------------------
// ZFApiHttpGetLoadPhotoSet
// --------------------------------------------------------------------
@interface ZFApiHttpGetLoadPhotoSet : NSObject{ 
@private
	ZFLoadPhotoSetHttpGetIn* _input;
	ZFPhotoSet* _output;
} 


@property (readwrite, retain, nonatomic) ZFLoadPhotoSetHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFPhotoSet* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetLoadPhotoSet*) apiHttpGetLoadPhotoSet; 

@end

@interface ZFApiHttpGetLoadPhotoSet (ValueProperties) 
@end


@interface ZFApiHttpGetLoadPhotoSet (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFLoadPhotoSetHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFPhotoSet* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

