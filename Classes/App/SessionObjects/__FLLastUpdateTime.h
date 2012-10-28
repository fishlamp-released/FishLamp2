// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLLastUpdateTime.h
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLLastUpdateTime
// --------------------------------------------------------------------
@interface FLLastUpdateTime : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __lastUpdateId;
    NSDate* __lastUpdate;
} 


@property (readwrite, strong, nonatomic) NSDate* lastUpdate;

@property (readwrite, strong, nonatomic) NSString* lastUpdateId;

+ (NSString*) lastUpdateIdKey;

+ (NSString*) lastUpdateKey;

+ (FLLastUpdateTime*) lastUpdateTime; 

@end

@interface FLLastUpdateTime (ValueProperties) 
@end

// [/Generated]
