//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookLikeList.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


@class GtFacebookNamedObject;

// --------------------------------------------------------------------
// GtFacebookLikeList
// --------------------------------------------------------------------
@interface GtFacebookLikeList : NSObject<NSCopying, NSCoding>{ 
@private
	NSNumber* m_count;
	NSMutableArray* m_data;
} 


@property (readwrite, retain, nonatomic) NSNumber* count;

@property (readwrite, retain, nonatomic) NSMutableArray* data;
// Type: GtFacebookNamedObject*, forKey: like

+ (NSString*) countKey;

+ (NSString*) dataKey;

+ (GtFacebookLikeList*) facebookLikeList; 

@end

@interface GtFacebookLikeList (ValueProperties) 

@property (readwrite, assign, nonatomic) int countValue;
@end

