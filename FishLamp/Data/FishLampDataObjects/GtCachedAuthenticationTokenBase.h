// This file was generated at 2/6/10 2:05 PM by PackMule. DO NOT MODIFY!!
//
// GtCachedAuthenticationTokenBase.h
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
// GtCachedAuthenticationTokenBase
// --------------------------------------------------------------------
@interface GtCachedAuthenticationTokenBase : GtObject{ 
} 

#if !IPHONE
+ (GtCachedAuthenticationTokenBase*) object;
+ (GtCachedAuthenticationTokenBase*) objectWithXmlParseKey:(NSString*) string;
+ (GtCachedAuthenticationTokenBase*) objectWithObject:(GtCachedAuthenticationTokenBase*) object;
#endif

// 
// Properties: 
// 

// token property
@property (readwrite, assign, nonatomic) NSString* token; // typesafe data for property
@property (readonly, assign, nonatomic) NSString* tokenObject; // object containing data in dictionary
+ (NSString*) tokenKey; // key for property in object dictionary
- (BOOL) tokenHasValue; // checks to see if object is nil in dictionary
- (void) removeToken; // removes object from dictionary

// id property
@property (readwrite, assign, nonatomic) int id; // typesafe data for property
@property (readonly, assign, nonatomic) NSNumber* idObject; // object containing data in dictionary
+ (NSString*) idKey; // key for property in object dictionary
- (BOOL) idHasValue; // checks to see if object is nil in dictionary
- (void) removeId; // removes object from dictionary

@end
#endif