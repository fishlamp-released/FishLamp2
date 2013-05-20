//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookComment.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookObject.h"
@class GtFacebookNamedObject;

// --------------------------------------------------------------------
// GtFacebookComment
// --------------------------------------------------------------------
@interface GtFacebookComment : GtFacebookObject<NSCopying, NSCoding>{ 
@private
	NSDate* m_created_time;
	NSString* m_message;
	GtFacebookNamedObject* m_from;
	NSNumber* m_likes;
} 


@property (readwrite, retain, nonatomic) NSDate* created_time;

@property (readwrite, retain, nonatomic) GtFacebookNamedObject* from;

@property (readwrite, retain, nonatomic) NSNumber* likes;

@property (readwrite, retain, nonatomic) NSString* message;

+ (NSString*) created_timeKey;

+ (NSString*) fromKey;

+ (NSString*) likesKey;

+ (NSString*) messageKey;

+ (GtFacebookComment*) facebookComment; 

@end

@interface GtFacebookComment (ValueProperties) 

@property (readwrite, assign, nonatomic) int likesValue;
@end

