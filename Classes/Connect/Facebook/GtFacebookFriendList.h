//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookFriendList.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtFacebookNamedObject.h"
@class GtFacebookNamedObject;

// --------------------------------------------------------------------
// GtFacebookFriendList
// --------------------------------------------------------------------
@interface GtFacebookFriendList : GtFacebookNamedObject<NSCopying, NSCoding>{ 
@private
	NSMutableArray* m_friends;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* friends;
// Type: GtFacebookNamedObject*, forKey: friend

+ (NSString*) friendsKey;

+ (GtFacebookFriendList*) facebookFriendList; 

@end

@interface GtFacebookFriendList (ValueProperties) 
@end

