// This file was generated at 2/6/10 2:03 PM by PackMule. DO NOT MODIFY!!
//
// GtUserLogin.h
// FishLamp
//
//
// Copywrite 2009 GreenTongue Software. All rights reserved.
//

#ifndef FISHLAMPDATAOBJECTS_ENABLED
#define FISHLAMPDATAOBJECTS_ENABLED 1
#endif
#if FISHLAMPDATAOBJECTS_ENABLED

#import "GtStringUtilities.h"
#import "GtObject.h"
#import "GtObjectArray.h"
#import "GtComplexObjectArray.h"
#import "GtCoreGeometry.h"

#import "GtPhotoData.h"


// --------------------------------------------------------------------
// GtUserLogin
// --------------------------------------------------------------------
@interface GtUserLogin : GtObject{ 
} 

#if !IPHONE
+ (GtUserLogin*) object;
+ (GtUserLogin*) objectWithXmlParseKey:(NSString*) string;
+ (GtUserLogin*) objectWithObject:(GtUserLogin*) object;
#endif

// 
// Properties: 
// 

// userName property
@property (readwrite, assign, nonatomic) NSString* userName; // typesafe data for property
@property (readonly, assign, nonatomic) NSString* userNameObject; // object containing data in dictionary
+ (NSString*) userNameKey; // key for property in object dictionary
- (BOOL) userNameHasValue; // checks to see if object is nil in dictionary
- (void) removeUserName; // removes object from dictionary

// password property
@property (readwrite, assign, nonatomic) NSString* password; // typesafe data for property
@property (readonly, assign, nonatomic) NSString* passwordObject; // object containing data in dictionary
+ (NSString*) passwordKey; // key for property in object dictionary
- (BOOL) passwordHasValue; // checks to see if object is nil in dictionary
- (void) removePassword; // removes object from dictionary

// userGuid property
@property (readwrite, assign, nonatomic) NSString* userGuid; // typesafe data for property
@property (readonly, assign, nonatomic) NSString* userGuidObject; // object containing data in dictionary
+ (NSString*) userGuidKey; // key for property in object dictionary
- (BOOL) userGuidHasValue; // checks to see if object is nil in dictionary
- (void) removeUserGuid; // removes object from dictionary

@end
#endif