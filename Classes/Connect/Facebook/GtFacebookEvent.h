//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookEvent.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookNamedObject.h"

// --------------------------------------------------------------------
// GtFacebookEvent
// --------------------------------------------------------------------
@interface GtFacebookEvent : GtFacebookNamedObject<NSCopying, NSCoding>{ 
@private
	NSString* m_owner;
	NSString* m_description;
	NSDate* m_start_time;
	NSDate* m_end_time;
	NSString* m_location;
	NSString* m_venue;
	NSString* m_privacy;
	NSDate* m_updated_time;
} 


@property (readwrite, retain, nonatomic) NSString* description;

@property (readwrite, retain, nonatomic) NSDate* end_time;

@property (readwrite, retain, nonatomic) NSString* location;

@property (readwrite, retain, nonatomic) NSString* owner;

@property (readwrite, retain, nonatomic) NSString* privacy;

@property (readwrite, retain, nonatomic) NSDate* start_time;

@property (readwrite, retain, nonatomic) NSDate* updated_time;

@property (readwrite, retain, nonatomic) NSString* venue;

+ (NSString*) descriptionKey;

+ (NSString*) end_timeKey;

+ (NSString*) locationKey;

+ (NSString*) ownerKey;

+ (NSString*) privacyKey;

+ (NSString*) start_timeKey;

+ (NSString*) updated_timeKey;

+ (NSString*) venueKey;

+ (GtFacebookEvent*) facebookEvent; 

@end

@interface GtFacebookEvent (ValueProperties) 
@end

