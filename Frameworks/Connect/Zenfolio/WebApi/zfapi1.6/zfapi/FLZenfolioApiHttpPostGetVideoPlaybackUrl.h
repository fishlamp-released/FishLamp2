//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioApiHttpPostGetVideoPlaybackUrl.h
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



@class FLZenfolioGetVideoPlaybackUrlHttpPostIn;

// --------------------------------------------------------------------
// FLZenfolioApiHttpPostGetVideoPlaybackUrl
// --------------------------------------------------------------------
@interface FLZenfolioApiHttpPostGetVideoPlaybackUrl : NSObject{ 
@private
	FLZenfolioGetVideoPlaybackUrlHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) FLZenfolioGetVideoPlaybackUrlHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZenfolioApiHttpPostGetVideoPlaybackUrl*) apiHttpPostGetVideoPlaybackUrl; 

@end

@interface FLZenfolioApiHttpPostGetVideoPlaybackUrl (ValueProperties) 
@end


@interface FLZenfolioApiHttpPostGetVideoPlaybackUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZenfolioGetVideoPlaybackUrlHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

