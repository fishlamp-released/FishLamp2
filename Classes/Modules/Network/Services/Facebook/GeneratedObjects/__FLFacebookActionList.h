// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookActionList.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


@class FLFacebookAction;

// --------------------------------------------------------------------
// FLFacebookActionList
// --------------------------------------------------------------------
@interface FLFacebookActionList : NSObject<NSCopying, NSCoding>{ 
@private
    NSNumber* __count;
    NSMutableArray* __data;
} 


@property (readwrite, strong, nonatomic) NSNumber* count;

@property (readwrite, strong, nonatomic) NSMutableArray* data;
/// Type: FLFacebookAction*, forKey: like

+ (NSString*) countKey;

+ (NSString*) dataKey;

+ (FLFacebookActionList*) facebookActionList; 

@end

@interface FLFacebookActionList (ValueProperties) 

@property (readwrite, assign, nonatomic) int countValue;
@end

// [/Generated]
