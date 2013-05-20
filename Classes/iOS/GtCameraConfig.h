//	This file was generated at 7/3/11 12:00 PM by PackMule. DO NOT MODIFY!!
//
//	GtCameraConfig.h
//	Project: FishLamp Mobile
//	Schema: MobilePhotoObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtCameraConfig
// --------------------------------------------------------------------
@interface GtCameraConfig : NSObject<NSCopying, NSCoding>{ 
@private
	NSNumber* m_captureDevicePosition;
	NSNumber* m_captureFlashMode;
	NSNumber* m_captureTorchMode;
	NSNumber* m_captureFocusMode;
	NSNumber* m_captureWhiteBalanceMode;
	NSNumber* m_showGuidelines;
	NSNumber* m_showStabityTracker;
	NSNumber* m_showZoom;
	NSNumber* m_foo;
} 


@property (readwrite, retain, nonatomic) NSNumber* captureDevicePosition;

@property (readwrite, retain, nonatomic) NSNumber* captureFlashMode;

@property (readwrite, retain, nonatomic) NSNumber* captureFocusMode;

@property (readwrite, retain, nonatomic) NSNumber* captureTorchMode;

@property (readwrite, retain, nonatomic) NSNumber* captureWhiteBalanceMode;

@property (readwrite, retain, nonatomic) NSNumber* foo;

@property (readwrite, retain, nonatomic) NSNumber* showGuidelines;

@property (readwrite, retain, nonatomic) NSNumber* showStabityTracker;

@property (readwrite, retain, nonatomic) NSNumber* showZoom;

+ (NSString*) captureDevicePositionKey;

+ (NSString*) captureFlashModeKey;

+ (NSString*) captureFocusModeKey;

+ (NSString*) captureTorchModeKey;

+ (NSString*) captureWhiteBalanceModeKey;

+ (NSString*) fooKey;

+ (NSString*) showGuidelinesKey;

+ (NSString*) showStabityTrackerKey;

+ (NSString*) showZoomKey;

+ (GtCameraConfig*) cameraConfig; 

@end

@interface GtCameraConfig (ValueProperties) 

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

