//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookMessage.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookObject.h"
@class GtFacebookEmailObject;

// --------------------------------------------------------------------
// GtFacebookMessage
// --------------------------------------------------------------------
@interface GtFacebookMessage : GtFacebookObject<NSCopying, NSCoding>{ 
@private
	GtFacebookEmailObject* m_from;
	GtFacebookEmailObject* m_to;
	NSString* m_message;
	NSDate* m_created_time;
} 


@property (readwrite, retain, nonatomic) NSDate* created_time;

@property (readwrite, retain, nonatomic) GtFacebookEmailObject* from;

@property (readwrite, retain, nonatomic) NSString* message;

@property (readwrite, retain, nonatomic) GtFacebookEmailObject* to;

+ (NSString*) created_timeKey;

+ (NSString*) fromKey;

+ (NSString*) messageKey;

+ (NSString*) toKey;

+ (GtFacebookMessage*) facebookMessage; 

@end

@interface GtFacebookMessage (ValueProperties) 
@end

