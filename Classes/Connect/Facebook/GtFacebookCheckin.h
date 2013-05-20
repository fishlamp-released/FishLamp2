//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookCheckin.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookObject.h"
@class GtFacebookObject;
@class GtFacebookDataList;
@class GtFacebookPlace;
@class GtFacebookNamedObject;

// --------------------------------------------------------------------
// GtFacebookCheckin
// --------------------------------------------------------------------
@interface GtFacebookCheckin : GtFacebookObject<NSCopying, NSCoding>{ 
@private
	GtFacebookObject* m_from;
	GtFacebookDataList* m_tags;
	GtFacebookPlace* m_place;
	NSString* m_message;
	GtFacebookNamedObject* m_application;
	NSDate* m_created_time;
} 


@property (readwrite, retain, nonatomic) GtFacebookNamedObject* application;

@property (readwrite, retain, nonatomic) NSDate* created_time;

@property (readwrite, retain, nonatomic) GtFacebookObject* from;

@property (readwrite, retain, nonatomic) NSString* message;

@property (readwrite, retain, nonatomic) GtFacebookPlace* place;

@property (readwrite, retain, nonatomic) GtFacebookDataList* tags;

+ (NSString*) applicationKey;

+ (NSString*) created_timeKey;

+ (NSString*) fromKey;

+ (NSString*) messageKey;

+ (NSString*) placeKey;

+ (NSString*) tagsKey;

+ (GtFacebookCheckin*) facebookCheckin; 

@end

@interface GtFacebookCheckin (ValueProperties) 
@end

