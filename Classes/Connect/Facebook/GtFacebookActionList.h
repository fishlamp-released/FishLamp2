//	This file was generated at 7/8/11 6:43 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookActionList.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


@class GtFacebookAction;

// --------------------------------------------------------------------
// GtFacebookActionList
// --------------------------------------------------------------------
@interface GtFacebookActionList : NSObject<NSCopying, NSCoding>{ 
@private
	NSNumber* m_count;
	NSMutableArray* m_data;
} 


@property (readwrite, retain, nonatomic) NSNumber* count;

@property (readwrite, retain, nonatomic) NSMutableArray* data;
// Type: GtFacebookAction*, forKey: like

+ (NSString*) countKey;

+ (NSString*) dataKey;

+ (GtFacebookActionList*) facebookActionList; 

@end

@interface GtFacebookActionList (ValueProperties) 

@property (readwrite, assign, nonatomic) int countValue;
@end

