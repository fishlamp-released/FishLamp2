//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookNote.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookObject.h"
@class GtFacebookNamedObject;

// --------------------------------------------------------------------
// GtFacebookNote
// --------------------------------------------------------------------
@interface GtFacebookNote : GtFacebookObject<NSCopying, NSCoding>{ 
@private
	GtFacebookNamedObject* m_from;
	NSString* m_subject;
	NSString* m_message;
	NSString* m_icon;
	NSDate* m_updated_time;
	NSDate* m_created_time;
} 


@property (readwrite, retain, nonatomic) NSDate* created_time;

@property (readwrite, retain, nonatomic) GtFacebookNamedObject* from;

@property (readwrite, retain, nonatomic) NSString* icon;

@property (readwrite, retain, nonatomic) NSString* message;

@property (readwrite, retain, nonatomic) NSString* subject;

@property (readwrite, retain, nonatomic) NSDate* updated_time;

+ (NSString*) created_timeKey;

+ (NSString*) fromKey;

+ (NSString*) iconKey;

+ (NSString*) messageKey;

+ (NSString*) subjectKey;

+ (NSString*) updated_timeKey;

+ (GtFacebookNote*) facebookNote; 

@end

@interface GtFacebookNote (ValueProperties) 
@end

