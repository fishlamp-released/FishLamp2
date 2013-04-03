//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapGetRecentPhotos.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Retrieves recently added photos (most recent at the top).  <A href="/Zenfolio/help/api/ref/methods/getrecentphotos">More...</A>
*/



@class ZFGetRecentPhotos;
@class ZFGetRecentPhotosResponse;

// --------------------------------------------------------------------
// ZFApiSoapGetRecentPhotos
// --------------------------------------------------------------------
@interface ZFApiSoapGetRecentPhotos : NSObject{ 
@private
	ZFGetRecentPhotos* _input;
	ZFGetRecentPhotosResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetRecentPhotos* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFGetRecentPhotosResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapGetRecentPhotos*) apiSoapGetRecentPhotos; 

@end

@interface ZFApiSoapGetRecentPhotos (ValueProperties) 
@end


@interface ZFApiSoapGetRecentPhotos (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetRecentPhotos* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFGetRecentPhotosResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

