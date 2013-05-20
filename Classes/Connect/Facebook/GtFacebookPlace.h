//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookPlace.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookNamedObject.h"

// --------------------------------------------------------------------
// GtFacebookPlace
// --------------------------------------------------------------------
@interface GtFacebookPlace : GtFacebookNamedObject<NSCopying, NSCoding>{ 
@private
	NSString* m_location;
} 


@property (readwrite, retain, nonatomic) NSString* location;

+ (NSString*) locationKey;

+ (GtFacebookPlace*) facebookPlace; 

@end

@interface GtFacebookPlace (ValueProperties) 
@end

