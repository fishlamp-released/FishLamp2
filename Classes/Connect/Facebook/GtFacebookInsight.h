//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookInsight.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtFacebookInsight
// --------------------------------------------------------------------
@interface GtFacebookInsight : NSObject{ 
@private
	NSNumber* m_value;
	NSDate* m_end_time;
} 


@property (readwrite, retain, nonatomic) NSDate* end_time;

@property (readwrite, retain, nonatomic) NSNumber* value;

+ (NSString*) end_timeKey;

+ (NSString*) valueKey;

+ (GtFacebookInsight*) facebookInsight; 

@end

@interface GtFacebookInsight (ValueProperties) 

@property (readwrite, assign, nonatomic) int valueValue;
@end

