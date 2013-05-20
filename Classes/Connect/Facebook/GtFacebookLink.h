//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookLink.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookNamedObject.h"
@class GtFacebookObject;

// --------------------------------------------------------------------
// GtFacebookLink
// --------------------------------------------------------------------
@interface GtFacebookLink : GtFacebookNamedObject<NSCopying, NSCoding>{ 
@private
	GtFacebookObject* m_from;
	NSString* m_link;
	NSString* m_caption;
	NSString* m_description;
	NSString* m_icon;
	NSString* m_picture;
	NSString* m_message;
	NSDate* m_created_time;
} 


@property (readwrite, retain, nonatomic) NSString* caption;

@property (readwrite, retain, nonatomic) NSDate* created_time;

@property (readwrite, retain, nonatomic) NSString* description;

@property (readwrite, retain, nonatomic) GtFacebookObject* from;

@property (readwrite, retain, nonatomic) NSString* icon;

@property (readwrite, retain, nonatomic) NSString* link;

@property (readwrite, retain, nonatomic) NSString* message;

@property (readwrite, retain, nonatomic) NSString* picture;

+ (NSString*) captionKey;

+ (NSString*) created_timeKey;

+ (NSString*) descriptionKey;

+ (NSString*) fromKey;

+ (NSString*) iconKey;

+ (NSString*) linkKey;

+ (NSString*) messageKey;

+ (NSString*) pictureKey;

+ (GtFacebookLink*) facebookLink; 

@end

@interface GtFacebookLink (ValueProperties) 
@end

