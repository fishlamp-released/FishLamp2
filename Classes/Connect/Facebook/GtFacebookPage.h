//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookPage.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookNamedObject.h"

// --------------------------------------------------------------------
// GtFacebookPage
// --------------------------------------------------------------------
@interface GtFacebookPage : GtFacebookNamedObject<NSCopying, NSCoding>{ 
@private
	NSString* m_category;
	NSNumber* m_likes;
} 


@property (readwrite, retain, nonatomic) NSString* category;

@property (readwrite, retain, nonatomic) NSNumber* likes;

+ (NSString*) categoryKey;

+ (NSString*) likesKey;

+ (GtFacebookPage*) facebookPage; 

@end

@interface GtFacebookPage (ValueProperties) 

@property (readwrite, assign, nonatomic) int likesValue;
@end

