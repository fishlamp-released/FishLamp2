// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookNamedObjectList.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


@class FLFacebookNamedObject;

// --------------------------------------------------------------------
// FLFacebookNamedObjectList
// --------------------------------------------------------------------
@interface FLFacebookNamedObjectList : NSObject<NSCopying, NSCoding>{ 
@private
    NSNumber* __count;
    NSMutableArray* __data;
} 


@property (readwrite, strong, nonatomic) NSNumber* count;

@property (readwrite, strong, nonatomic) NSMutableArray* data;
/// Type: FLFacebookNamedObject*, forKey: like

+ (NSString*) countKey;

+ (NSString*) dataKey;

+ (FLFacebookNamedObjectList*) facebookNamedObjectList; 

@end

@interface FLFacebookNamedObjectList (ValueProperties) 

@property (readwrite, assign, nonatomic) int countValue;
@end

// [/Generated]
