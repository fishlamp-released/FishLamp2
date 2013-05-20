//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookStatusMessage.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookObject.h"
@class GtFacebookNamedObject;

// --------------------------------------------------------------------
// GtFacebookStatusMessage
// --------------------------------------------------------------------
@interface GtFacebookStatusMessage : GtFacebookObject<NSCopying, NSCoding>{ 
@private
	GtFacebookNamedObject* m_from;
	NSString* m_message;
	NSDate* m_updated_time;
} 


@property (readwrite, retain, nonatomic) GtFacebookNamedObject* from;

@property (readwrite, retain, nonatomic) NSString* message;

@property (readwrite, retain, nonatomic) NSDate* updated_time;

+ (NSString*) fromKey;

+ (NSString*) messageKey;

+ (NSString*) updated_timeKey;

+ (GtFacebookStatusMessage*) facebookStatusMessage; 

@end

@interface GtFacebookStatusMessage (ValueProperties) 
@end

