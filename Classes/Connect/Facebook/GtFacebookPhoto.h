//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookPhoto.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookNamedObject.h"
@class GtFacebookNamedObject;
@class GtFacebookTag;

// --------------------------------------------------------------------
// GtFacebookPhoto
// --------------------------------------------------------------------
@interface GtFacebookPhoto : GtFacebookNamedObject<NSCopying, NSCoding>{ 
@private
	GtFacebookNamedObject* m_from;
	NSDate* m_updated_time;
	NSDate* m_created_time;
	NSString* m_link;
	NSString* m_icon;
	NSString* m_source;
	NSNumber* m_height;
	NSNumber* m_width;
	NSMutableArray* m_tags;
} 


@property (readwrite, retain, nonatomic) NSDate* created_time;

@property (readwrite, retain, nonatomic) GtFacebookNamedObject* from;

@property (readwrite, retain, nonatomic) NSNumber* height;

@property (readwrite, retain, nonatomic) NSString* icon;

@property (readwrite, retain, nonatomic) NSString* link;

@property (readwrite, retain, nonatomic) NSString* source;

@property (readwrite, retain, nonatomic) NSMutableArray* tags;
// Type: GtFacebookTag*, forKey: tag

@property (readwrite, retain, nonatomic) NSDate* updated_time;

@property (readwrite, retain, nonatomic) NSNumber* width;

+ (NSString*) created_timeKey;

+ (NSString*) fromKey;

+ (NSString*) heightKey;

+ (NSString*) iconKey;

+ (NSString*) linkKey;

+ (NSString*) sourceKey;

+ (NSString*) tagsKey;

+ (NSString*) updated_timeKey;

+ (NSString*) widthKey;

+ (GtFacebookPhoto*) facebookPhoto; 

@end

@interface GtFacebookPhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int heightValue;

@property (readwrite, assign, nonatomic) int widthValue;
@end

