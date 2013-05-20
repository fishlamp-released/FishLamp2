//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookInsights.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookNamedObject.h"
@class GtFacebookInsight;

// --------------------------------------------------------------------
// GtFacebookInsights
// --------------------------------------------------------------------
@interface GtFacebookInsights : GtFacebookNamedObject<NSCopying, NSCoding>{ 
@private
	NSString* m_period;
	NSMutableArray* m_values;
} 


@property (readwrite, retain, nonatomic) NSString* period;

@property (readwrite, retain, nonatomic) NSMutableArray* values;
// Type: GtFacebookInsight*, forKey: insights

+ (NSString*) periodKey;

+ (NSString*) valuesKey;

+ (GtFacebookInsights*) facebookInsights; 

@end

@interface GtFacebookInsights (ValueProperties) 
@end

