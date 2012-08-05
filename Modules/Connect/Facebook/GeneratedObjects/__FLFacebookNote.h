// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookNote.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLFacebookObject.h"
@class FLFacebookNamedObject;

// --------------------------------------------------------------------
// FLFacebookNote
// --------------------------------------------------------------------
@interface FLFacebookNote : FLFacebookObject<NSCopying, NSCoding>{ 
@private
    FLFacebookNamedObject* __from;
    NSString* __subject;
    NSString* __message;
    NSString* __icon;
    NSDate* __updated_time;
    NSDate* __created_time;
} 


@property (readwrite, strong, nonatomic) NSDate* created_time;

@property (readwrite, strong, nonatomic) FLFacebookNamedObject* from;

@property (readwrite, strong, nonatomic) NSString* icon;

@property (readwrite, strong, nonatomic) NSString* message;

@property (readwrite, strong, nonatomic) NSString* subject;

@property (readwrite, strong, nonatomic) NSDate* updated_time;

+ (NSString*) created_timeKey;

+ (NSString*) fromKey;

+ (NSString*) iconKey;

+ (NSString*) messageKey;

+ (NSString*) subjectKey;

+ (NSString*) updated_timeKey;

+ (FLFacebookNote*) facebookNote; 

@end

@interface FLFacebookNote (ValueProperties) 
@end

// [/Generated]
