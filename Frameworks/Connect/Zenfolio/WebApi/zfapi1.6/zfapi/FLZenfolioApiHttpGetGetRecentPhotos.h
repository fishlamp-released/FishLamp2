//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetGetRecentPhotos.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Retrieves recently added photos (most recent at the top).  <A href="/Zenfolio/help/api/ref/methods/getrecentphotos">More...</A>
*/



@class FLZenfolioGetRecentPhotosHttpGetIn;
@class FLZenfolioPhoto;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetGetRecentPhotos
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetGetRecentPhotos : NSObject{ 
@private
	FLZenfolioGetRecentPhotosHttpGetIn* _input;
	NSMutableArray* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetRecentPhotosHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSMutableArray* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
// Type: FLZenfolioPhoto*, forKey: Photo

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetGetRecentPhotos*) apiHttpGetGetRecentPhotos; 

@end

@interface FLZenfolioApiHttpGetGetRecentPhotos (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetGetRecentPhotos (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetRecentPhotosHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* outputObject;
// This returns _output. It does NOT create it if it's NIL.
// Type: FLZenfolioPhoto*, forKey: Photo

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

