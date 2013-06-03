// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLSavedThemeInfo.h
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

// --------------------------------------------------------------------
// FLSavedThemeInfo
// --------------------------------------------------------------------
@interface FLSavedThemeInfo : FLModelObject{ 
@private
    NSString* __name;
    NSString* __className;
    NSNumber* __fontSize;
} 


@property (readwrite, strong, nonatomic) NSString* className;

@property (readwrite, strong, nonatomic) NSNumber* fontSize;

@property (readwrite, strong, nonatomic) NSString* name;

+ (NSString*) classNameKey;

+ (NSString*) fontSizeKey;

+ (NSString*) nameKey;

+ (FLSavedThemeInfo*) savedThemeInfo; 

@end

@interface FLSavedThemeInfo (ValueProperties) 

@property (readwrite, assign, nonatomic) int fontSizeValue;
@end

// [/Generated]
