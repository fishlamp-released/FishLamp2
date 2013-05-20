//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookCommentList.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


@class GtFacebookComment;

// --------------------------------------------------------------------
// GtFacebookCommentList
// --------------------------------------------------------------------
@interface GtFacebookCommentList : NSObject<NSCopying, NSCoding>{ 
@private
	NSNumber* m_count;
	NSMutableArray* m_data;
} 


@property (readwrite, retain, nonatomic) NSNumber* count;

@property (readwrite, retain, nonatomic) NSMutableArray* data;
// Type: GtFacebookComment*, forKey: comment

+ (NSString*) countKey;

+ (NSString*) dataKey;

+ (GtFacebookCommentList*) facebookCommentList; 

@end

@interface GtFacebookCommentList (ValueProperties) 

@property (readwrite, assign, nonatomic) int countValue;
@end

