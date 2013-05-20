//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookAlbum.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookNamedObject.h"
@class GtFacebookNamedObject;

// --------------------------------------------------------------------
// GtFacebookAlbum
// --------------------------------------------------------------------
@interface GtFacebookAlbum : GtFacebookNamedObject<NSCopying, NSCoding>{ 
@private
	NSString* m_description;
	GtFacebookNamedObject* m_from;
	NSString* m_location;
	NSString* m_link;
	NSString* m_cover_photo;
	NSString* m_privacy;
	NSString* m_count;
	NSString* m_type;
	NSDate* m_created_time;
	NSDate* m_updated_time;
} 


@property (readwrite, retain, nonatomic) NSString* count;

@property (readwrite, retain, nonatomic) NSString* cover_photo;

@property (readwrite, retain, nonatomic) NSDate* created_time;

@property (readwrite, retain, nonatomic) NSString* description;

@property (readwrite, retain, nonatomic) GtFacebookNamedObject* from;

@property (readwrite, retain, nonatomic) NSString* link;

@property (readwrite, retain, nonatomic) NSString* location;

@property (readwrite, retain, nonatomic) NSString* privacy;

@property (readwrite, retain, nonatomic) NSString* type;

@property (readwrite, retain, nonatomic) NSDate* updated_time;

+ (NSString*) countKey;

+ (NSString*) cover_photoKey;

+ (NSString*) created_timeKey;

+ (NSString*) descriptionKey;

+ (NSString*) fromKey;

+ (NSString*) linkKey;

+ (NSString*) locationKey;

+ (NSString*) privacyKey;

+ (NSString*) typeKey;

+ (NSString*) updated_timeKey;

+ (GtFacebookAlbum*) facebookAlbum; 

@end

@interface GtFacebookAlbum (ValueProperties) 
@end

