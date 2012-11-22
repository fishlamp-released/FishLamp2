// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookFriendList.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookNamedObject.h"
@class FLFacebookNamedObject;

// --------------------------------------------------------------------
// FLFacebookFriendList
// --------------------------------------------------------------------
@interface FLFacebookFriendList : FLFacebookNamedObject<NSCopying, NSCoding>{ 
@private
    NSMutableArray* __friends;
} 


@property (readwrite, strong, nonatomic) NSMutableArray* friends;
/// Type: FLFacebookNamedObject*, forKey: friend

+ (NSString*) friendsKey;

+ (FLFacebookFriendList*) facebookFriendList; 

@end

@interface FLFacebookFriendList (ValueProperties) 
@end

// [/Generated]
