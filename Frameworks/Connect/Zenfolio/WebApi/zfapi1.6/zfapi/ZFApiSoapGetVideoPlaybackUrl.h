//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapGetVideoPlaybackUrl.h
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



@class ZFGetVideoPlaybackUrl;
@class ZFGetVideoPlaybackUrlResponse;

// --------------------------------------------------------------------
// ZFApiSoapGetVideoPlaybackUrl
// --------------------------------------------------------------------
@interface ZFApiSoapGetVideoPlaybackUrl : NSObject{ 
@private
	ZFGetVideoPlaybackUrl* _input;
	ZFGetVideoPlaybackUrlResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetVideoPlaybackUrl* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFGetVideoPlaybackUrlResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapGetVideoPlaybackUrl*) apiSoapGetVideoPlaybackUrl; 

@end

@interface ZFApiSoapGetVideoPlaybackUrl (ValueProperties) 
@end


@interface ZFApiSoapGetVideoPlaybackUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetVideoPlaybackUrl* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFGetVideoPlaybackUrlResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

