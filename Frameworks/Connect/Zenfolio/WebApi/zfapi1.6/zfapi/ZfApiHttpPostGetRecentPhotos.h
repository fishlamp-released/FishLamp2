//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostGetRecentPhotos.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Retrieves recently added photos (most recent at the top).  <A href="/zf/help/api/ref/methods/getrecentphotos">More...</A>
*/



@class ZFGetRecentPhotosHttpPostIn;
@class ZFPhoto;

// --------------------------------------------------------------------
// ZFApiHttpPostGetRecentPhotos
// --------------------------------------------------------------------
@interface ZFApiHttpPostGetRecentPhotos : NSObject{ 
@private
	ZFGetRecentPhotosHttpPostIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetRecentPhotosHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: ZFPhoto*, forKey: Photo

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostGetRecentPhotos*) apiHttpPostGetRecentPhotos; 

@end

@interface ZFApiHttpPostGetRecentPhotos (ValueProperties) 
@end


@interface ZFApiHttpPostGetRecentPhotos (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetRecentPhotosHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: ZFPhoto*, forKey: Photo

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

