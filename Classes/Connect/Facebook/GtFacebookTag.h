//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookTag.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


@class GtFacebookNamedObject;

// --------------------------------------------------------------------
// GtFacebookTag
// --------------------------------------------------------------------
@interface GtFacebookTag : NSObject{ 
@private
	GtFacebookNamedObject* m_user;
	NSNumber* m_x;
	NSNumber* m_y;
} 


@property (readwrite, retain, nonatomic) GtFacebookNamedObject* user;

@property (readwrite, retain, nonatomic) NSNumber* x;

@property (readwrite, retain, nonatomic) NSNumber* y;

+ (NSString*) userKey;

+ (NSString*) xKey;

+ (NSString*) yKey;

+ (GtFacebookTag*) facebookTag; 

@end

@interface GtFacebookTag (ValueProperties) 

@property (readwrite, assign, nonatomic) int xValue;

@property (readwrite, assign, nonatomic) int yValue;
@end

