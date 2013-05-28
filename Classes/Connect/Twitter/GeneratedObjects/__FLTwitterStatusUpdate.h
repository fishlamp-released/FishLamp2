// [Generated]
//
// This file was generated at 6/18/12 2:01 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLTwitterStatusUpdate.h
// Project: FishLamp
// Schema: Twitter
//
// Copywrite (C) 2012 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// FLTwitterStatusUpdate
// --------------------------------------------------------------------
@interface FLTwitterStatusUpdate : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __status;
    NSString* __in_reply_to_status_id;
    NSString* __place_id;
    NSString* __display_coordinates;
    NSString* __trim_user;
    NSString* __include_entities;
} 


@property (readwrite, strong, nonatomic) NSString* display_coordinates;

@property (readwrite, strong, nonatomic) NSString* in_reply_to_status_id;

@property (readwrite, strong, nonatomic) NSString* include_entities;

@property (readwrite, strong, nonatomic) NSString* place_id;

@property (readwrite, strong, nonatomic) NSString* status;

@property (readwrite, strong, nonatomic) NSString* trim_user;

+ (NSString*) display_coordinatesKey;

+ (NSString*) in_reply_to_status_idKey;

+ (NSString*) include_entitiesKey;

+ (NSString*) place_idKey;

+ (NSString*) statusKey;

+ (NSString*) trim_userKey;

+ (FLTwitterStatusUpdate*) twitterStatusUpdate; 

@end

@interface FLTwitterStatusUpdate (ValueProperties) 
@end

// [/Generated]
