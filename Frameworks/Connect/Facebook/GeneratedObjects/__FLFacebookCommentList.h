// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookCommentList.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


@class FLFacebookComment;

// --------------------------------------------------------------------
// FLFacebookCommentList
// --------------------------------------------------------------------
@interface FLFacebookCommentList : NSObject<NSCopying, NSCoding>{ 
@private
    NSNumber* __count;
    NSMutableArray* __data;
} 


@property (readwrite, strong, nonatomic) NSNumber* count;

@property (readwrite, strong, nonatomic) NSMutableArray* data;
/// Type: FLFacebookComment*, forKey: comment

+ (NSString*) countKey;

+ (NSString*) dataKey;

+ (FLFacebookCommentList*) facebookCommentList; 

@end

@interface FLFacebookCommentList (ValueProperties) 

@property (readwrite, assign, nonatomic) int countValue;
@end

// [/Generated]