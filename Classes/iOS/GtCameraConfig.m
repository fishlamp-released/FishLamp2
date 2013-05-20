//	This file was generated at 7/16/11 4:17 PM by PackMule. DO NOT MODIFY!!
//
//	GtCameraConfig.m
//	Project: FishLamp Mobile
//	Schema: MobilePhotoObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCameraConfig.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtCameraConfig


@synthesize captureDevicePosition = m_captureDevicePosition;
@synthesize captureFlashMode = m_captureFlashMode;
@synthesize captureFocusMode = m_captureFocusMode;
@synthesize captureTorchMode = m_captureTorchMode;
@synthesize captureWhiteBalanceMode = m_captureWhiteBalanceMode;
@synthesize foo = m_foo;
@synthesize showGuidelines = m_showGuidelines;
@synthesize showStabityTracker = m_showStabityTracker;
@synthesize showZoom = m_showZoom;

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

+ (GtCameraConfig*) cameraConfig
{
	return GtReturnAutoreleased([[GtCameraConfig alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCameraConfig*)object).captureDevicePosition = GtCopyOrRetainObject(m_captureDevicePosition);
	((GtCameraConfig*)object).showStabityTracker = GtCopyOrRetainObject(m_showStabityTracker);
	((GtCameraConfig*)object).foo = GtCopyOrRetainObject(m_foo);
	((GtCameraConfig*)object).captureFlashMode = GtCopyOrRetainObject(m_captureFlashMode);
	((GtCameraConfig*)object).showZoom = GtCopyOrRetainObject(m_showZoom);
	((GtCameraConfig*)object).showGuidelines = GtCopyOrRetainObject(m_showGuidelines);
	((GtCameraConfig*)object).captureFocusMode = GtCopyOrRetainObject(m_captureFocusMode);
	((GtCameraConfig*)object).captureTorchMode = GtCopyOrRetainObject(m_captureTorchMode);
	((GtCameraConfig*)object).captureWhiteBalanceMode = GtCopyOrRetainObject(m_captureWhiteBalanceMode);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_captureDevicePosition);
	GtRelease(m_captureFlashMode);
	GtRelease(m_captureTorchMode);
	GtRelease(m_captureFocusMode);
	GtRelease(m_captureWhiteBalanceMode);
	GtRelease(m_showGuidelines);
	GtRelease(m_showStabityTracker);
	GtRelease(m_showZoom);
	GtRelease(m_foo);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_captureDevicePosition) [aCoder encodeObject:m_captureDevicePosition forKey:@"m_captureDevicePosition"];
	if(m_captureFlashMode) [aCoder encodeObject:m_captureFlashMode forKey:@"m_captureFlashMode"];
	if(m_captureTorchMode) [aCoder encodeObject:m_captureTorchMode forKey:@"m_captureTorchMode"];
	if(m_captureFocusMode) [aCoder encodeObject:m_captureFocusMode forKey:@"m_captureFocusMode"];
	if(m_captureWhiteBalanceMode) [aCoder encodeObject:m_captureWhiteBalanceMode forKey:@"m_captureWhiteBalanceMode"];
	if(m_showGuidelines) [aCoder encodeObject:m_showGuidelines forKey:@"m_showGuidelines"];
	if(m_showStabityTracker) [aCoder encodeObject:m_showStabityTracker forKey:@"m_showStabityTracker"];
	if(m_showZoom) [aCoder encodeObject:m_showZoom forKey:@"m_showZoom"];
	if(m_foo) [aCoder encodeObject:m_foo forKey:@"m_foo"];
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
		m_captureDevicePosition = [[aDecoder decodeObjectForKey:@"m_captureDevicePosition"] retain];
		m_captureFlashMode = [[aDecoder decodeObjectForKey:@"m_captureFlashMode"] retain];
		m_captureTorchMode = [[aDecoder decodeObjectForKey:@"m_captureTorchMode"] retain];
		m_captureFocusMode = [[aDecoder decodeObjectForKey:@"m_captureFocusMode"] retain];
		m_captureWhiteBalanceMode = [[aDecoder decodeObjectForKey:@"m_captureWhiteBalanceMode"] retain];
		m_showGuidelines = [[aDecoder decodeObjectForKey:@"m_showGuidelines"] retain];
		m_showStabityTracker = [[aDecoder decodeObjectForKey:@"m_showStabityTracker"] retain];
		m_showZoom = [[aDecoder decodeObjectForKey:@"m_showZoom"] retain];
		m_foo = [[aDecoder decodeObjectForKey:@"m_foo"] retain];
	}
	return self;
}

+ (GtObjectDescriber*) sharedObjectDescriber
{
	static GtObjectDescriber* s_describer = nil;
	if(!s_describer)
	{
		@synchronized(self) {
			if(!s_describer)
			{
				s_describer = [[super sharedObjectDescriber] copy];
				if(!s_describer)
				{
					s_describer = [[GtObjectDescriber alloc] init];
				}
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"captureDevicePosition" propertyClass:[NSNumber class] propertyType:GtDataTypeNSInteger] forPropertyName:@"captureDevicePosition"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"captureFlashMode" propertyClass:[NSNumber class] propertyType:GtDataTypeNSInteger] forPropertyName:@"captureFlashMode"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"captureTorchMode" propertyClass:[NSNumber class] propertyType:GtDataTypeNSInteger] forPropertyName:@"captureTorchMode"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"captureFocusMode" propertyClass:[NSNumber class] propertyType:GtDataTypeNSInteger] forPropertyName:@"captureFocusMode"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"captureWhiteBalanceMode" propertyClass:[NSNumber class] propertyType:GtDataTypeNSInteger] forPropertyName:@"captureWhiteBalanceMode"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"showGuidelines" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"showGuidelines"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"showStabityTracker" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"showStabityTracker"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"showZoom" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"showZoom"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"foo" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"foo"];
			}
		}
	}
	return s_describer;
}

+ (GtObjectInflator*) sharedObjectInflator
{
	static GtObjectInflator* s_inflator = nil;
	if(!s_inflator)
	{
		@synchronized(self) {
			if(!s_inflator)
			{
				s_inflator = [[GtObjectInflator alloc] initWithObjectDescriber:[[self class] sharedObjectDescriber]];
			}
		}
	}
	return s_inflator;
}

+ (GtSqliteTable*) sharedSqliteTable
{
	static GtSqliteTable* s_table = nil;
	if(!s_table)
	{
		@synchronized(self) {
			if(!s_table)
			{
				GtSqliteTable* superTable = [super sharedSqliteTable];
				if(superTable)
				{
					s_table = [superTable copy];
					s_table.tableName = [self sqliteTableName];
				}
				else
				{
					s_table = [[GtSqliteTable alloc] initWithTableName:[self sqliteTableName]];
				}
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"captureDevicePosition" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"captureFlashMode" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"captureTorchMode" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"captureFocusMode" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"captureWhiteBalanceMode" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"showGuidelines" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"showStabityTracker" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"showZoom" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"foo" columnType:GtSqliteTypeInteger columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCameraConfig (ValueProperties) 

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

