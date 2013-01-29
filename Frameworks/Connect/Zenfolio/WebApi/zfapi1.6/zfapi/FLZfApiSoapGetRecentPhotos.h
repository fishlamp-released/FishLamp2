//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapGetRecentPhotos.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Retrieves recently added photos (most recent at the top).  <A href="/zf/help/api/ref/methods/getrecentphotos">More...</A>
*/



@class FLZfGetRecentPhotos;
@class FLZfGetRecentPhotosResponse;

// --------------------------------------------------------------------
// FLZfApiSoapGetRecentPhotos
// --------------------------------------------------------------------
@interface FLZfApiSoapGetRecentPhotos : NSObject{ 
@private
	FLZfGetRecentPhotos* _input;
	FLZfGetRecentPhotosResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfGetRecentPhotos* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfGetRecentPhotosResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapGetRecentPhotos*) apiSoapGetRecentPhotos; 

@end

@interface FLZfApiSoapGetRecentPhotos (ValueProperties) 
@end


@interface FLZfApiSoapGetRecentPhotos (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfGetRecentPhotos* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfGetRecentPhotosResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

