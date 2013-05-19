// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLApplicationDataVersion.h
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// FLApplicationDataVersion
// --------------------------------------------------------------------
@interface FLApplicationDataVersion : NSObject{ 
@private
    NSString* __userGuid;
    NSString* __versionString;
} 


@property (readwrite, strong, nonatomic) NSString* userGuid;

@property (readwrite, strong, nonatomic) NSString* versionString;

+ (NSString*) userGuidKey;

+ (NSString*) versionStringKey;

+ (FLApplicationDataVersion*) applicationDataVersion; 

@end

@interface FLApplicationDataVersion (ValueProperties) 
@end

// [/Generated]
