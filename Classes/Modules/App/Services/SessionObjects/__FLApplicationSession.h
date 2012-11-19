// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLApplicationSession.h
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLApplicationSession
// --------------------------------------------------------------------
@interface FLApplicationSession : NSObject<NSCopying, NSCoding>{ 
@private
    NSNumber* __sessionId;
    NSString* __userGuid;
} 


@property (readwrite, strong, nonatomic) NSNumber* sessionId;

@property (readwrite, strong, nonatomic) NSString* userGuid;

+ (NSString*) sessionIdKey;

+ (NSString*) userGuidKey;

+ (FLApplicationSession*) applicationSession; 

@end

@interface FLApplicationSession (ValueProperties) 

@property (readwrite, assign, nonatomic) int sessionIdValue;
@end

// [/Generated]
