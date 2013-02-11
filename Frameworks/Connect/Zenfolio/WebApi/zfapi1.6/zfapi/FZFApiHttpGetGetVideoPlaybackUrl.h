//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpGetGetVideoPlaybackUrl.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Returns the video playback URL for the specified video. <A href="/Zenfolio/help/api/ref/methods/getvideoplaybackurl">More...</A>
*/



@class FLZenfolioGetVideoPlaybackUrlHttpGetIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpGetGetVideoPlaybackUrl
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpGetGetVideoPlaybackUrl : NSObject{ 
@private
	FLZenfolioGetVideoPlaybackUrlHttpGetIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetVideoPlaybackUrlHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpGetGetVideoPlaybackUrl*) apiHttpGetGetVideoPlaybackUrl; 

@end

@interface FLZenfolioApiHttpGetGetVideoPlaybackUrl (ValueProperties) 
@end


@interface FLZenfolioApiHttpGetGetVideoPlaybackUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetVideoPlaybackUrlHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

