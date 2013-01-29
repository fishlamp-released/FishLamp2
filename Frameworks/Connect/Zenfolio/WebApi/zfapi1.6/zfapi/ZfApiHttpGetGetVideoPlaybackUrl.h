//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetGetVideoPlaybackUrl.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Returns the video playback URL for the specified video. <A href="/zf/help/api/ref/methods/getvideoplaybackurl">More...</A>
*/



@class ZFGetVideoPlaybackUrlHttpGetIn;

// --------------------------------------------------------------------
// ZFApiHttpGetGetVideoPlaybackUrl
// --------------------------------------------------------------------
@interface ZFApiHttpGetGetVideoPlaybackUrl : NSObject{ 
@private
	ZFGetVideoPlaybackUrlHttpGetIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetVideoPlaybackUrlHttpGetIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpGetGetVideoPlaybackUrl*) apiHttpGetGetVideoPlaybackUrl; 

@end

@interface ZFApiHttpGetGetVideoPlaybackUrl (ValueProperties) 
@end


@interface ZFApiHttpGetGetVideoPlaybackUrl (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetVideoPlaybackUrlHttpGetIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

