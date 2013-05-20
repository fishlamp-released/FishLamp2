//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookVideo.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookNamedObject.h"
@class GtFacebookNamedObject;
@class GtFacebookTag;

// --------------------------------------------------------------------
// GtFacebookVideo
// --------------------------------------------------------------------
@interface GtFacebookVideo : GtFacebookNamedObject<NSCopying, NSCoding>{ 
@private
	GtFacebookNamedObject* m_from;
	NSDate* m_updated_time;
	NSDate* m_created_time;
	NSString* m_embed_html;
	NSString* m_icon;
	NSString* m_source;
	NSMutableArray* m_tags;
} 


@property (readwrite, retain, nonatomic) NSDate* created_time;

@property (readwrite, retain, nonatomic) NSString* embed_html;

@property (readwrite, retain, nonatomic) GtFacebookNamedObject* from;

@property (readwrite, retain, nonatomic) NSString* icon;

@property (readwrite, retain, nonatomic) NSString* source;

@property (readwrite, retain, nonatomic) NSMutableArray* tags;
// Type: GtFacebookTag*, forKey: tag

@property (readwrite, retain, nonatomic) NSDate* updated_time;

+ (NSString*) created_timeKey;

+ (NSString*) embed_htmlKey;

+ (NSString*) fromKey;

+ (NSString*) iconKey;

+ (NSString*) sourceKey;

+ (NSString*) tagsKey;

+ (NSString*) updated_timeKey;

+ (GtFacebookVideo*) facebookVideo; 

@end

@interface GtFacebookVideo (ValueProperties) 
@end

