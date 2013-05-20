//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookWorkHistory.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookNamedObject.h"
@class GtFacebookNamedObject;

// --------------------------------------------------------------------
// GtFacebookWorkHistory
// --------------------------------------------------------------------
@interface GtFacebookWorkHistory : GtFacebookNamedObject<NSCopying, NSCoding>{ 
@private
	GtFacebookNamedObject* m_employer;
	GtFacebookNamedObject* m_location;
	GtFacebookNamedObject* m_position;
	NSDate* m_start_date;
	NSDate* m_end_date;
} 


@property (readwrite, retain, nonatomic) GtFacebookNamedObject* employer;

@property (readwrite, retain, nonatomic) NSDate* end_date;

@property (readwrite, retain, nonatomic) GtFacebookNamedObject* location;

@property (readwrite, retain, nonatomic) GtFacebookNamedObject* position;

@property (readwrite, retain, nonatomic) NSDate* start_date;

+ (NSString*) employerKey;

+ (NSString*) end_dateKey;

+ (NSString*) locationKey;

+ (NSString*) positionKey;

+ (NSString*) start_dateKey;

+ (GtFacebookWorkHistory*) facebookWorkHistory; 

@end

@interface GtFacebookWorkHistory (ValueProperties) 
@end

