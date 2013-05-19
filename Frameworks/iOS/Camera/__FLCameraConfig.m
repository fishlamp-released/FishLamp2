// [Generated]
//
// This file was generated at 6/18/12 2:01 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCameraConfig.m
// Project: FishLamp Mobile
// Schema: MobilePhotoObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCameraConfig.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLCameraConfig


@synthesize captureDevicePosition = __captureDevicePosition;
@synthesize captureFlashMode = __captureFlashMode;
@synthesize captureFocusMode = __captureFocusMode;
@synthesize captureTorchMode = __captureTorchMode;
@synthesize captureWhiteBalanceMode = __captureWhiteBalanceMode;
@synthesize foo = __foo;
@synthesize showGuidelines = __showGuidelines;
@synthesize showStabityTracker = __showStabityTracker;
@synthesize showZoom = __showZoom;

+ (NSString*) captureDevicePositionKey
{
    return @"captureDevicePosition";
}

+ (NSString*) captureFlashModeKey
{
    return @"captureFlashMode";
}

+ (NSString*) captureFocusModeKey
{
    return @"captureFocusMode";
}

+ (NSString*) captureTorchModeKey
{
    return @"captureTorchMode";
}

+ (NSString*) captureWhiteBalanceModeKey
{
    return @"captureWhiteBalanceMode";
}

+ (NSString*) fooKey
{
    return @"foo";
}

+ (NSString*) showGuidelinesKey
{
    return @"showGuidelines";
}

+ (NSString*) showStabityTrackerKey
{
    return @"showStabityTracker";
}

+ (NSString*) showZoomKey
{
    return @"showZoom";
}

+ (FLCameraConfig*) cameraConfig
{
    return FLAutorelease([[FLCameraConfig alloc] init]);
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLCameraConfig*)object).captureDevicePosition = FLCopyOrRetainObject(__captureDevicePosition);
    ((FLCameraConfig*)object).showStabityTracker = FLCopyOrRetainObject(__showStabityTracker);
    ((FLCameraConfig*)object).foo = FLCopyOrRetainObject(__foo);
    ((FLCameraConfig*)object).captureFlashMode = FLCopyOrRetainObject(__captureFlashMode);
    ((FLCameraConfig*)object).showZoom = FLCopyOrRetainObject(__showZoom);
    ((FLCameraConfig*)object).showGuidelines = FLCopyOrRetainObject(__showGuidelines);
    ((FLCameraConfig*)object).captureFocusMode = FLCopyOrRetainObject(__captureFocusMode);
    ((FLCameraConfig*)object).captureTorchMode = FLCopyOrRetainObject(__captureTorchMode);
    ((FLCameraConfig*)object).captureWhiteBalanceMode = FLCopyOrRetainObject(__captureWhiteBalanceMode);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__captureDevicePosition);
    FLRelease(__captureFlashMode);
    FLRelease(__captureTorchMode);
    FLRelease(__captureFocusMode);
    FLRelease(__captureWhiteBalanceMode);
    FLRelease(__showGuidelines);
    FLRelease(__showStabityTracker);
    FLRelease(__showZoom);
    FLRelease(__foo);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__captureDevicePosition) [aCoder encodeObject:__captureDevicePosition forKey:@"__captureDevicePosition"];
    if(__captureFlashMode) [aCoder encodeObject:__captureFlashMode forKey:@"__captureFlashMode"];
    if(__captureTorchMode) [aCoder encodeObject:__captureTorchMode forKey:@"__captureTorchMode"];
    if(__captureFocusMode) [aCoder encodeObject:__captureFocusMode forKey:@"__captureFocusMode"];
    if(__captureWhiteBalanceMode) [aCoder encodeObject:__captureWhiteBalanceMode forKey:@"__captureWhiteBalanceMode"];
    if(__showGuidelines) [aCoder encodeObject:__showGuidelines forKey:@"__showGuidelines"];
    if(__showStabityTracker) [aCoder encodeObject:__showStabityTracker forKey:@"__showStabityTracker"];
    if(__showZoom) [aCoder encodeObject:__showZoom forKey:@"__showZoom"];
    if(__foo) [aCoder encodeObject:__foo forKey:@"__foo"];
}

- (id) init
{
    if((self = [super init]))
    {
    }
    return self;
}

- (id) initWithCoder:(NSCoder*) aDecoder
{
    if((self = [super init]))
    {
        __captureDevicePosition = FLRetain([aDecoder decodeObjectForKey:@"__captureDevicePosition"]);
        __captureFlashMode = FLRetain([aDecoder decodeObjectForKey:@"__captureFlashMode"]);
        __captureTorchMode = FLRetain([aDecoder decodeObjectForKey:@"__captureTorchMode"]);
        __captureFocusMode = FLRetain([aDecoder decodeObjectForKey:@"__captureFocusMode"]);
        __captureWhiteBalanceMode = FLRetain([aDecoder decodeObjectForKey:@"__captureWhiteBalanceMode"]);
        __showGuidelines = FLRetain([aDecoder decodeObjectForKey:@"__showGuidelines"]);
        __showStabityTracker = FLRetain([aDecoder decodeObjectForKey:@"__showStabityTracker"]);
        __showZoom = FLRetain([aDecoder decodeObjectForKey:@"__showZoom"]);
        __foo = FLRetain([aDecoder decodeObjectForKey:@"__foo"]);
    }
    return self;
}

+ (FLObjectDescriber*) objectDescriber
{
    
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        
		
            FLLegacyObjectDescriber* describer = [FLLegacyObjectDescriber registerClass:[self class]];
        
        

        [describer setPropertyDescriber:[FLPropertyDescriber propertyDescriber:@"captureDevicePosition" objectClass:[NSNumber class] objectDescriber:FLDataTypeNSInteger] forPropertyName:@"captureDevicePosition"];
        [describer setPropertyDescriber:[FLPropertyDescriber propertyDescriber:@"captureFlashMode" objectClass:[NSNumber class] objectDescriber:FLDataTypeNSInteger] forPropertyName:@"captureFlashMode"];
        [describer setPropertyDescriber:[FLPropertyDescriber propertyDescriber:@"captureTorchMode" objectClass:[NSNumber class] objectDescriber:FLDataTypeNSInteger] forPropertyName:@"captureTorchMode"];
        [describer setPropertyDescriber:[FLPropertyDescriber propertyDescriber:@"captureFocusMode" objectClass:[NSNumber class] objectDescriber:FLDataTypeNSInteger] forPropertyName:@"captureFocusMode"];
        [describer setPropertyDescriber:[FLPropertyDescriber propertyDescriber:@"captureWhiteBalanceMode" objectClass:[NSNumber class] objectDescriber:FLDataTypeNSInteger] forPropertyName:@"captureWhiteBalanceMode"];
        [describer setPropertyDescriber:[FLPropertyDescriber propertyDescriber:@"showGuidelines" objectClass:[NSNumber class] objectDescriber:FLDataTypeBool] forPropertyName:@"showGuidelines"];
        [describer setPropertyDescriber:[FLPropertyDescriber propertyDescriber:@"showStabityTracker" objectClass:[NSNumber class] objectDescriber:FLDataTypeBool] forPropertyName:@"showStabityTracker"];
        [describer setPropertyDescriber:[FLPropertyDescriber propertyDescriber:@"showZoom" objectClass:[NSNumber class] objectDescriber:FLDataTypeBool] forPropertyName:@"showZoom"];
        [describer setPropertyDescriber:[FLPropertyDescriber propertyDescriber:@"foo" objectClass:[NSNumber class] objectDescriber:FLDataTypeBool] forPropertyName:@"foo"];
    });
    return [FLObjectDescriber objectDescriber:[self class]];
}

+ (FLObjectInflator*) sharedObjectInflator
{
    static FLObjectInflator* s_inflator = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] objectDescriber]];
    });
    return s_inflator;
}

- (BOOL) isModelObject {
    return YES;
}
+ (BOOL) isModelObject {
    return YES;
}
+ (FLDatabaseTable*) sharedDatabaseTable

{
    static FLDatabaseTable* s_table = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"captureDevicePosition" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"captureFlashMode" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"captureTorchMode" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"captureFocusMode" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"captureWhiteBalanceMode" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"showGuidelines" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"showStabityTracker" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"showZoom" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"foo" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLCameraConfig (ValueProperties) 

- (NSInteger) captureDevicePositionValue
{
    return [self.captureDevicePosition integerValue];
}

- (void) setCaptureDevicePositionValue:(NSInteger) value
{
    self.captureDevicePosition = [NSNumber numberWithInteger:value];
}

- (NSInteger) captureFlashModeValue
{
    return [self.captureFlashMode integerValue];
}

- (void) setCaptureFlashModeValue:(NSInteger) value
{
    self.captureFlashMode = [NSNumber numberWithInteger:value];
}

- (NSInteger) captureTorchModeValue
{
    return [self.captureTorchMode integerValue];
}

- (void) setCaptureTorchModeValue:(NSInteger) value
{
    self.captureTorchMode = [NSNumber numberWithInteger:value];
}

- (NSInteger) captureFocusModeValue
{
    return [self.captureFocusMode integerValue];
}

- (void) setCaptureFocusModeValue:(NSInteger) value
{
    self.captureFocusMode = [NSNumber numberWithInteger:value];
}

- (NSInteger) captureWhiteBalanceModeValue
{
    return [self.captureWhiteBalanceMode integerValue];
}

- (void) setCaptureWhiteBalanceModeValue:(NSInteger) value
{
    self.captureWhiteBalanceMode = [NSNumber numberWithInteger:value];
}

- (BOOL) showGuidelinesValue
{
    return [self.showGuidelines boolValue];
}

- (void) setShowGuidelinesValue:(BOOL) value
{
    self.showGuidelines = [NSNumber numberWithBool:value];
}

- (BOOL) showStabityTrackerValue
{
    return [self.showStabityTracker boolValue];
}

- (void) setShowStabityTrackerValue:(BOOL) value
{
    self.showStabityTracker = [NSNumber numberWithBool:value];
}

- (BOOL) showZoomValue
{
    return [self.showZoom boolValue];
}

- (void) setShowZoomValue:(BOOL) value
{
    self.showZoom = [NSNumber numberWithBool:value];
}

- (BOOL) fooValue
{
    return [self.foo boolValue];
}

- (void) setFooValue:(BOOL) value
{
    self.foo = [NSNumber numberWithBool:value];
}
@end

// [/Generated]
