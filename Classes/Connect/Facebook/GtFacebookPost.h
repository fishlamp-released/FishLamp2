//	This file was generated at 7/9/11 12:55 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookPost.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookNamedObject.h"
@class GtFacebookNamedObject;
@class GtFacebookNamedObjectList;
@class GtFacebookPrivacy;
@class GtFacebookCommentList;
@class GtFacebookAction;
@class GtFacebookProperty;

// --------------------------------------------------------------------
// GtFacebookPost
// --------------------------------------------------------------------
@interface GtFacebookPost : GtFacebookNamedObject<NSCopying, NSCoding>{ 
@private
	NSString* m_object_id;
	GtFacebookNamedObject* m_from;
	GtFacebookNamedObjectList* m_to;
	NSString* m_message;
	NSString* m_picture;
	NSString* m_link;
	NSString* m_caption;
	NSString* m_description;
	NSString* m_source;
	NSString* m_icon;
	NSMutableArray* m_properties;
	GtFacebookNamedObject* m_application;
	GtFacebookPrivacy* m_privacy;
	GtFacebookCommentList* m_comments;
	GtFacebookNamedObjectList* m_likes;
	NSMutableArray* m_actions;
	NSString* m_type;
	NSDate* m_updated_time;
	NSDate* m_created_time;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* actions;
// Type: GtFacebookAction*, forKey: action

@property (readwrite, retain, nonatomic) GtFacebookNamedObject* application;

@property (readwrite, retain, nonatomic) NSString* caption;

@property (readwrite, retain, nonatomic) GtFacebookCommentList* comments;

@property (readwrite, retain, nonatomic) NSDate* created_time;

@property (readwrite, retain, nonatomic) NSString* description;

@property (readwrite, retain, nonatomic) GtFacebookNamedObject* from;

@property (readwrite, retain, nonatomic) NSString* icon;

@property (readwrite, retain, nonatomic) GtFacebookNamedObjectList* likes;

@property (readwrite, retain, nonatomic) NSString* link;

@property (readwrite, retain, nonatomic) NSString* message;

@property (readwrite, retain, nonatomic) NSString* object_id;

@property (readwrite, retain, nonatomic) NSString* picture;

@property (readwrite, retain, nonatomic) GtFacebookPrivacy* privacy;

@property (readwrite, retain, nonatomic) NSMutableArray* properties;
// Type: GtFacebookProperty*, forKey: property

@property (readwrite, retain, nonatomic) NSString* source;

@property (readwrite, retain, nonatomic) GtFacebookNamedObjectList* to;

@property (readwrite, retain, nonatomic) NSString* type;

@property (readwrite, retain, nonatomic) NSDate* updated_time;

+ (NSString*) actionsKey;

+ (NSString*) applicationKey;

+ (NSString*) captionKey;

+ (NSString*) commentsKey;

+ (NSString*) created_timeKey;

+ (NSString*) descriptionKey;

+ (NSString*) fromKey;

+ (NSString*) iconKey;

+ (NSString*) likesKey;

+ (NSString*) linkKey;

+ (NSString*) messageKey;

+ (NSString*) object_idKey;

+ (NSString*) pictureKey;

+ (NSString*) privacyKey;

+ (NSString*) propertiesKey;

+ (NSString*) sourceKey;

+ (NSString*) toKey;

+ (NSString*) typeKey;

+ (NSString*) updated_timeKey;

+ (GtFacebookPost*) facebookPost; 

@end

@interface GtFacebookPost (ValueProperties) 
@end

