// [Generated]
//
// This file was generated at 6/18/12 2:01 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCameraConfig.h
// Project: FishLamp Mobile
// Schema: MobilePhotoObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// FLCameraConfig
// --------------------------------------------------------------------
@interface FLCameraConfig : NSObject<NSCopying, NSCoding>{ 
@private
    NSNumber* __captureDevicePosition;
    NSNumber* __captureFlashMode;
    NSNumber* __captureTorchMode;
    NSNumber* __captureFocusMode;
    NSNumber* __captureWhiteBalanceMode;
    NSNumber* __showGuidelines;
    NSNumber* __showStabityTracker;
    NSNumber* __showZoom;
    NSNumber* __foo;
} 


@property (readwrite, strong, nonatomic) NSNumber* captureDevicePosition;

@property (readwrite, strong, nonatomic) NSNumber* captureFlashMode;

@property (readwrite, strong, nonatomic) NSNumber* captureFocusMode;

@property (readwrite, strong, nonatomic) NSNumber* captureTorchMode;

@property (readwrite, strong, nonatomic) NSNumber* captureWhiteBalanceMode;

@property (readwrite, strong, nonatomic) NSNumber* foo;

@property (readwrite, strong, nonatomic) NSNumber* showGuidelines;

@property (readwrite, strong, nonatomic) NSNumber* showStabityTracker;

@property (readwrite, strong, nonatomic) NSNumber* showZoom;

+ (NSString*) captureDevicePositionKey;

+ (NSString*) captureFlashModeKey;

+ (NSString*) captureFocusModeKey;

+ (NSString*) captureTorchModeKey;

+ (NSString*) captureWhiteBalanceModeKey;

+ (NSString*) fooKey;

+ (NSString*) showGuidelinesKey;

+ (NSString*) showStabityTrackerKey;

+ (NSString*) showZoomKey;

+ (FLCameraConfig*) cameraConfig; 

@end

@interface FLCameraConfig (ValueProperties) 

@property (readwrite, assign, nonatomic) NSInteger captureDevicePositionValue;

@property (readwrite, assign, nonatomic) NSInteger captureFlashModeValue;

@property (readwrite, assign, nonatomic) NSInteger captureTorchModeValue;

@property (readwrite, assign, nonatomic) NSInteger captureFocusModeValue;

@property (readwrite, assign, nonatomic) NSInteger captureWhiteBalanceModeValue;

@property (readwrite, assign, nonatomic) BOOL showGuidelinesValue;

@property (readwrite, assign, nonatomic) BOOL showStabityTrackerValue;

@property (readwrite, assign, nonatomic) BOOL showZoomValue;

@property (readwrite, assign, nonatomic) BOOL fooValue;
@end

// [/Generated]
