//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookUpdateStatusOperation.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtHttpOperation.h"
@class GtFacebookStatusMessage;

// --------------------------------------------------------------------
// GtFacebookUpdateStatusOperation
// --------------------------------------------------------------------
@interface GtFacebookUpdateStatusOperation : GtHttpOperation{ 
@private
	GtFacebookStatusMessage* m_input;
	NSString* m_output;
} 


@property (readwrite, retain, nonatomic) GtFacebookStatusMessage* input;

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (GtFacebookUpdateStatusOperation*) facebookUpdateStatusOperation; 

@end

@interface GtFacebookUpdateStatusOperation (ValueProperties) 
@end

