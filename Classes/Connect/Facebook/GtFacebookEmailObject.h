//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookEmailObject.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookNamedObject.h"

// --------------------------------------------------------------------
// GtFacebookEmailObject
// --------------------------------------------------------------------
@interface GtFacebookEmailObject : GtFacebookNamedObject<NSCopying, NSCoding>{ 
@private
	NSString* m_email;
} 


@property (readwrite, retain, nonatomic) NSString* email;

+ (NSString*) emailKey;

+ (GtFacebookEmailObject*) facebookEmailObject; 

@end

@interface GtFacebookEmailObject (ValueProperties) 
@end

