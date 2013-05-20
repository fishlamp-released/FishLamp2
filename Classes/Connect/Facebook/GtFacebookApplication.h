//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookApplication.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookNamedObject.h"

// --------------------------------------------------------------------
// GtFacebookApplication
// --------------------------------------------------------------------
@interface GtFacebookApplication : GtFacebookNamedObject<NSCopying, NSCoding>{ 
@private
	NSString* m_category;
	NSString* m_link;
	NSString* m_description;
} 


@property (readwrite, retain, nonatomic) NSString* category;

@property (readwrite, retain, nonatomic) NSString* description;

@property (readwrite, retain, nonatomic) NSString* link;

+ (NSString*) categoryKey;

+ (NSString*) descriptionKey;

+ (NSString*) linkKey;

+ (GtFacebookApplication*) facebookApplication; 

@end

@interface GtFacebookApplication (ValueProperties) 
@end

