//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookGroup.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookNamedObject.h"

// --------------------------------------------------------------------
// GtFacebookGroup
// --------------------------------------------------------------------
@interface GtFacebookGroup : GtFacebookNamedObject<NSCopying, NSCoding>{ 
@private
	NSString* m_owner;
	NSString* m_icon;
	NSString* m_description;
	NSString* m_link;
	NSString* m_privacy;
	NSDate* m_updated_time;
} 


@property (readwrite, retain, nonatomic) NSString* description;

@property (readwrite, retain, nonatomic) NSString* icon;

@property (readwrite, retain, nonatomic) NSString* link;

@property (readwrite, retain, nonatomic) NSString* owner;

@property (readwrite, retain, nonatomic) NSString* privacy;

@property (readwrite, retain, nonatomic) NSDate* updated_time;

+ (NSString*) descriptionKey;

+ (NSString*) iconKey;

+ (NSString*) linkKey;

+ (NSString*) ownerKey;

+ (NSString*) privacyKey;

+ (NSString*) updated_timeKey;

+ (GtFacebookGroup*) facebookGroup; 

@end

@interface GtFacebookGroup (ValueProperties) 
@end

