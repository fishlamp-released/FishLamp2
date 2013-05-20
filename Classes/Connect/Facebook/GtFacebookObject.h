//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookObject.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtFacebookObject
// --------------------------------------------------------------------
@interface GtFacebookObject : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_id;
} 


@property (readwrite, retain, nonatomic) NSString* id;

+ (NSString*) idKey;

+ (GtFacebookObject*) facebookObject; 

@end

@interface GtFacebookObject (ValueProperties) 
@end

