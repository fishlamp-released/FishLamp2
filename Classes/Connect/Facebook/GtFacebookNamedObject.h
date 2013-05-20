//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookNamedObject.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookObject.h"

// --------------------------------------------------------------------
// GtFacebookNamedObject
// --------------------------------------------------------------------
@interface GtFacebookNamedObject : GtFacebookObject<NSCopying, NSCoding>{ 
@private
	NSString* m_name;
} 


@property (readwrite, retain, nonatomic) NSString* name;

+ (NSString*) nameKey;

+ (GtFacebookNamedObject*) facebookNamedObject; 

@end

@interface GtFacebookNamedObject (ValueProperties) 
@end

