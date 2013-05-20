//	This file was generated at 3/11/12 1:33 PM by PackMule. DO NOT MODIFY!!
//
//	GtThemeDescriptor.h
//	Project: FishLamp
//	Schema: GtThemeDescriptor
//
//	Copywrite 2011 GreentTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtThemeDescriptor
// --------------------------------------------------------------------
@interface GtThemeDescriptor : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_themeName;
	UIColor* m_backgroundColor;
} 


@property (readwrite, retain, nonatomic) UIColor* backgroundColor;

@property (readwrite, retain, nonatomic) NSString* themeName;

+ (NSString*) backgroundColorKey;

+ (NSString*) themeNameKey;

+ (GtThemeDescriptor*) themeDescriptor; 

@end

@interface GtThemeDescriptor (ValueProperties) 
@end

