// This file was generated at 1/23/10 8:43 PM by PackMule. DO NOT MODIFY!!
//
// GtCachedPhotoDataBase.h
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
// GtCachedPhotoDataBase
// --------------------------------------------------------------------
@interface GtCachedPhotoDataBase : GtObject{ 
} 

#if !IPHONE
+ (GtCachedPhotoDataBase*) object;
+ (GtCachedPhotoDataBase*) objectWithXmlParseKey:(NSString*) string;
+ (GtCachedPhotoDataBase*) objectWithObject:(GtCachedPhotoDataBase*) object;
#endif

// 
// Properties: 
// 

// filePath property
@property (readwrite, assign, nonatomic) NSString* filePath; // typesafe data for property
@property (readonly, assign, nonatomic) NSString* filePathObject; // object containing data in dictionary
+ (NSString*) filePathKey; // key for property in object dictionary
- (BOOL) filePathHasValue; // checks to see if object is nil in dictionary
- (void) removeFilePath; // removes object from dictionary

// url property
@property (readwrite, assign, nonatomic) NSString* url; // typesafe data for property
@property (readonly, assign, nonatomic) NSString* urlObject; // object containing data in dictionary
+ (NSString*) urlKey; // key for property in object dictionary
- (BOOL) urlHasValue; // checks to see if object is nil in dictionary
- (void) removeUrl; // removes object from dictionary

@end
#endif