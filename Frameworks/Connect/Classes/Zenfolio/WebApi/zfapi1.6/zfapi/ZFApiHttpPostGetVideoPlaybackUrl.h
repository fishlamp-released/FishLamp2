//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostGetVideoPlaybackUrl.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Returns the video playback URL for the specified video. <A href="/Zenfolio/help/api/ref/methods/getvideoplaybackurl">More...</A>
*/



@class ZFGetVideoPlaybackUrlHttpPostIn;

// --------------------------------------------------------------------
// ZFApiHttpPostGetVideoPlaybackUrl
// --------------------------------------------------------------------
@interface ZFApiHttpPostGetVideoPlaybackUrl : NSObject{ 
@private
	ZFGetVideoPlaybackUrlHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetVideoPlaybackUrlHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostGetVideoPlaybackUrl*) apiHttpPostGetVideoPlaybackUrl; 

@end

@interface ZFApiHttpPostGetVideoPlaybackUrl (ValueProperties) 
@end


@interface ZFApiHttpPostGetVideoPlaybackUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetVideoPlaybackUrlHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

