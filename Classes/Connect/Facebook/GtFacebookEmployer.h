//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookEmployer.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookNamedObject.h"

// --------------------------------------------------------------------
// GtFacebookEmployer
// --------------------------------------------------------------------
@interface GtFacebookEmployer : GtFacebookNamedObject<NSCopying, NSCoding>{ 
@private
	NSString* m_employer;
	NSString* m_location;
	NSString* m_position;
	NSDate* m_start_date;
	NSDate* m_end_date;
} 


@property (readwrite, retain, nonatomic) NSString* employer;

@property (readwrite, retain, nonatomic) NSDate* end_date;

@property (readwrite, retain, nonatomic) NSString* location;

@property (readwrite, retain, nonatomic) NSString* position;

@property (readwrite, retain, nonatomic) NSDate* start_date;

+ (NSString*) employerKey;

+ (NSString*) end_dateKey;

+ (NSString*) locationKey;

+ (NSString*) positionKey;

+ (NSString*) start_dateKey;

+ (GtFacebookEmployer*) facebookEmployer; 

@end

@interface GtFacebookEmployer (ValueProperties) 
@end

