//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtTwitterStatusUpdate.h
//	Project: FishLamp
//	Schema: Twitter
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtTwitterStatusUpdate
// --------------------------------------------------------------------
@interface GtTwitterStatusUpdate : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_status;
	NSString* m_in_reply_to_status_id;
	NSString* m_place_id;
	NSString* m_display_coordinates;
	NSString* m_trim_user;
	NSString* m_include_entities;
} 


@property (readwrite, retain, nonatomic) NSString* display_coordinates;

@property (readwrite, retain, nonatomic) NSString* in_reply_to_status_id;

@property (readwrite, retain, nonatomic) NSString* include_entities;

@property (readwrite, retain, nonatomic) NSString* place_id;

@property (readwrite, retain, nonatomic) NSString* status;

@property (readwrite, retain, nonatomic) NSString* trim_user;

+ (NSString*) display_coordinatesKey;

+ (NSString*) in_reply_to_status_idKey;

+ (NSString*) include_entitiesKey;

+ (NSString*) place_idKey;

+ (NSString*) statusKey;

+ (NSString*) trim_userKey;

+ (GtTwitterStatusUpdate*) twitterStatusUpdate; 

@end

@interface GtTwitterStatusUpdate (ValueProperties) 
@end

