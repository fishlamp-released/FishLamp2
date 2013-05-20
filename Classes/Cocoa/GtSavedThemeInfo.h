//	This file was generated at 7/10/11 11:15 AM by PackMule. DO NOT MODIFY!!
//
//	GtSavedThemeInfo.h
//	Project: FishLamp
//	Schema: GtGeneratedCoreObjects
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtDatabaseObject.h"

// --------------------------------------------------------------------
// GtSavedThemeInfo
// --------------------------------------------------------------------
@interface GtSavedThemeInfo : GtDatabaseObject<NSCopying, NSCoding>{ 
@private
	NSString* m_name;
	NSString* m_className;
	NSNumber* m_fontSize;
} 


@property (readwrite, retain, nonatomic) NSString* className;

@property (readwrite, retain, nonatomic) NSNumber* fontSize;

@property (readwrite, retain, nonatomic) NSString* name;

+ (NSString*) classNameKey;

+ (NSString*) fontSizeKey;

+ (NSString*) nameKey;

+ (GtSavedThemeInfo*) savedThemeInfo; 

@end

@interface GtSavedThemeInfo (ValueProperties) 

@property (readwrite, assign, nonatomic) int fontSizeValue;
@end

