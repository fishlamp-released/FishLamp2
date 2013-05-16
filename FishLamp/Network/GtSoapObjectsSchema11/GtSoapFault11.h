// This file was generated at 12/27/09 11:38 AM by PackMule. DO NOT MODIFY!!
//
// GtSoapFault11.h
// FishLamp
//
//
// Copywrite 2009 GreenTongue Software. All rights reserved.
//

#ifndef GTSOAPOBJECTSSCHEMA11_ENABLED
#define GTSOAPOBJECTSSCHEMA11_ENABLED 1
#endif
#if GTSOAPOBJECTSSCHEMA11_ENABLED

#import "GtStringUtilities.h"
#import "GtObject.h"
#import "GtObjectArray.h"
#import "GtComplexObjectArray.h"
#import "GtCoreGeometry.h"


// --------------------------------------------------------------------
// GtSoapFault11
// --------------------------------------------------------------------
@interface GtSoapFault11 : GtObject{ 
} 

#if !IPHONE
+ (GtSoapFault11*) object;
+ (GtSoapFault11*) objectWithXmlParseKey:(NSString*) string;
+ (GtSoapFault11*) objectWithObject:(GtSoapFault11*) object;
#endif

// 
// Properties: 
// 

// faultcode property
@property (readwrite, assign, nonatomic) NSString* faultcode; // typesafe data for property
@property (readonly, assign, nonatomic) NSString* faultcodeObject; // object containing data in dictionary
+ (NSString*) faultcodeKey; // key for property in object dictionary
- (BOOL) faultcodeHasValue; // checks to see if object is nil in dictionary
- (void) removeFaultcode; // removes object from dictionary

// faultstring property
@property (readwrite, assign, nonatomic) NSString* faultstring; // typesafe data for property
@property (readonly, assign, nonatomic) NSString* faultstringObject; // object containing data in dictionary
+ (NSString*) faultstringKey; // key for property in object dictionary
- (BOOL) faultstringHasValue; // checks to see if object is nil in dictionary
- (void) removeFaultstring; // removes object from dictionary

// faultactor property
@property (readwrite, assign, nonatomic) NSString* faultactor; // typesafe data for property
@property (readonly, assign, nonatomic) NSString* faultactorObject; // object containing data in dictionary
+ (NSString*) faultactorKey; // key for property in object dictionary
- (BOOL) faultactorHasValue; // checks to see if object is nil in dictionary
- (void) removeFaultactor; // removes object from dictionary

// detail property
@property (readwrite, assign, nonatomic) NSString* detail; // typesafe data for property
@property (readonly, assign, nonatomic) NSString* detailObject; // object containing data in dictionary
+ (NSString*) detailKey; // key for property in object dictionary
- (BOOL) detailHasValue; // checks to see if object is nil in dictionary
- (void) removeDetail; // removes object from dictionary

@end
#endif