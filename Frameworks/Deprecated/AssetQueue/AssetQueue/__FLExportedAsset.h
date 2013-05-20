// [Generated]
//
// This file was generated at 6/18/12 2:02 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLExportedAsset.h
// Project: FishLamp Mobile
// Schema: AssetQueueObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// FLExportedAsset
// --------------------------------------------------------------------
@interface FLExportedAsset : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __originalID;
    NSString* __assetURL;
    NSDate* __exportedDate;
} 


@property (readwrite, strong, nonatomic) NSString* assetURL;

@property (readwrite, strong, nonatomic) NSDate* exportedDate;

@property (readwrite, strong, nonatomic) NSString* originalID;

+ (NSString*) assetURLKey;

+ (NSString*) exportedDateKey;

+ (NSString*) originalIDKey;

+ (FLExportedAsset*) exportedAsset; 

@end

@interface FLExportedAsset (ValueProperties) 
@end

// [/Generated]
