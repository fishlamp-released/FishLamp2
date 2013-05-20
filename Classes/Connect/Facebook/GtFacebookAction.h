//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookAction.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtFacebookAction
// --------------------------------------------------------------------
@interface GtFacebookAction : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_link;
	NSString* m_name;
} 


@property (readwrite, retain, nonatomic) NSString* link;

@property (readwrite, retain, nonatomic) NSString* name;

+ (NSString*) linkKey;

+ (NSString*) nameKey;

+ (GtFacebookAction*) facebookAction; 

@end

@interface GtFacebookAction (ValueProperties) 
@end

