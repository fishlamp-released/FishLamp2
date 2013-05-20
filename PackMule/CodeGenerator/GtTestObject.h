//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtTestObject.h
//	Project: FishLamp
//	Schema: GtTestObjects
//
//	Copywrite 2011 GreentTongue Software. All rights reserved.
//


#import "GtTestObjectsEnums.h"
@class GtGuid;
@class GtXmlParser;

// --------------------------------------------------------------------
// GtTestObject
// --------------------------------------------------------------------
@interface GtTestObject : NSObject<NSCopying, NSCoding>{ 
@private
	NSNumber* m_testInt;
	NSNumber* m_anotherInt;
	NSValue* m_rect;
	NSValue* m_point;
	NSValue* m_size;
	NSString* m_stateEnum;
	NSNumber* m_myBool;
	GtGuid* m_databaseGuid;
	NSDate* m_dateModified;
	NSDate* m_dateCreated;
	NSDate* m_expireDate;
	NSString* m_foo;
	NSString* m_myString;
	NSNumber* m_testFloat;
	NSMutableArray* m_anArray;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* anArray;
// Getter will create m_anArray if nil. Alternately, use the anArrayObject property, which will not lazy create it.
// Type: NSString*, forKey: item
// Type: NSNumber*, forKey: number
// Type: GtXmlParser*, forKey: parser

@property (readwrite, retain, nonatomic) NSNumber* anotherInt;

@property (readwrite, retain, nonatomic) GtGuid* databaseGuid;
// Getter will create m_databaseGuid if nil. Alternately, use the databaseGuidObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSDate* dateCreated;
// This is the date the object was created

@property (readwrite, retain, nonatomic) NSDate* dateModified;

@property (readwrite, retain, nonatomic) NSDate* expireDate;

@property (readwrite, retain, nonatomic) NSString* foo;

@property (readonly, retain, nonatomic) NSString* foop;

@property (readwrite, retain, nonatomic) NSNumber* myBool;

@property (readwrite, retain, nonatomic) NSString* myString;

@property (readwrite, retain, nonatomic) NSValue* point;

@property (readwrite, retain, nonatomic) NSValue* rect;

@property (readwrite, retain, nonatomic) NSValue* size;

@property (readwrite, retain, nonatomic) NSString* stateEnum;

@property (readwrite, retain, nonatomic) NSNumber* testFloat;

@property (readwrite, retain, nonatomic) NSNumber* testInt;

+ (NSString*) anArrayKey;

+ (NSString*) anotherIntKey;

+ (NSString*) databaseGuidKey;

+ (NSString*) dateCreatedKey;

+ (NSString*) dateModifiedKey;

+ (NSString*) expireDateKey;

+ (NSString*) fooKey;

+ (NSString*) foopy;
+ (void) setFoopy:(NSString*) foopy;

+ (NSString*) iLikeRum;

+ (NSString*) myBoolKey;

+ (NSString*) myStringKey;

+ (NSString*) pointKey;

+ (NSString*) rectKey;

+ (NSString*) sizeKey;

+ (NSString*) stateEnumKey;

+ (NSString*) testFloatKey;

+ (NSString*) testIntKey;

+ (GtTestObject*) testObject; 

@end

@interface GtTestObject (ValueProperties) 

@property (readwrite, assign, nonatomic) int testIntValue;

@property (readwrite, assign, nonatomic) int anotherIntValue;

@property (readwrite, assign, nonatomic) NSRect rectValue;

@property (readwrite, assign, nonatomic) NSPoint pointValue;

@property (readwrite, assign, nonatomic) NSSize sizeValue;

@property (readwrite, assign, nonatomic) GtMyEnum stateEnumValue;

@property (readwrite, assign, nonatomic) BOOL myBoolValue;

@property (readwrite, assign, nonatomic) float testFloatValue;
@end


@interface GtTestObject (ObjectMembers) 

@property (readonly, retain, nonatomic) GtGuid* databaseGuidObject;
// This returns m_databaseGuid. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) NSMutableArray* anArrayObject;
// This returns m_anArray. It does NOT create it if it's NIL.
// Type: NSString*, forKey: item
// Type: NSNumber*, forKey: number
// Type: GtXmlParser*, forKey: parser

- (void) createDatabaseGuidIfNil; 

- (void) createAnArrayIfNil; 
@end

