//
//	GtCameraExifTableViewBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/29/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCameraExifTableViewBuilder.h"
#import "GtWideSingleLineLabelAndValueCell.h"
#import "GtPhotoMapViewController.h"
#import "GtGpsUtilities.h"
#import "GtDisplayFormatters.h"

@implementation GtCameraExifTableViewBuilder 

@synthesize masterExif = m_masterExif;
@synthesize enableMapForGps = m_enableMapForGps;

- (id) init
{
	if((self = [super init]))
	{
		m_extras = [[NSMutableDictionary alloc] init];
		self.enableMapForGps = YES;
	}
	return self;
}

- (void) dealloc 
{
	GtRelease(m_builder);
	GtRelease(m_masterExif);
	GtRelease(m_extras);
	GtRelease(m_overrides);
	GtSuperDealloc();
}

- (void) setMasterExif:(NSDictionary*) dict
{
	GtRelease(m_masterExif);
	m_masterExif = [dict mutableCopy];
}

- (void) _addTiffData:(GtTableViewLayoutBuilder*) builder dataSourceManager:(GtDataSourceManager*) dataSourceManager exifDictionary:(NSDictionary*) exifDict
{
	[dataSourceManager setDataSource:GtReturnAutoreleased([exifDict mutableCopy]) forKey:(NSString*)kCGImagePropertyTIFFDictionary];
	
	if([exifDict objectForKey:(NSString*)kCGImagePropertyTIFFMake])
	{
		[builder addCell:[GtWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell:NSLocalizedString(@"Camera Make", nil) value:nil] forKey:GtKeyPathStringMake((NSString*)kCGImagePropertyTIFFDictionary, (NSString*)kCGImagePropertyTIFFMake)];
	}
	
	if([exifDict objectForKey:(NSString*)kCGImagePropertyTIFFModel])
	{
		[builder addCell:[GtWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell:NSLocalizedString(@"Camera Model", nil) value:nil] forKey:GtKeyPathStringMake((NSString*)kCGImagePropertyTIFFDictionary, (NSString*)kCGImagePropertyTIFFModel)];
	}
	
	if([exifDict objectForKey:(NSString*)kCGImagePropertyTIFFSoftware])
	{
		[builder addCell:[GtWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell:NSLocalizedString(@"Version", @"Exif - camera version") value:nil] forKey:GtKeyPathStringMake((NSString*)kCGImagePropertyTIFFDictionary, (NSString*)kCGImagePropertyTIFFSoftware)];
	}
}

- (void) setExifOverride:(id) value keyPath:(NSString*) keyPath
{
	if(!m_overrides)
	{
		m_overrides = [[NSMutableDictionary alloc] init];
	}	
	
	[m_overrides setObject:value forKey:keyPath];
}

+ (NSString*) flashModeStringFromFlashMode:(int) flashMode
{
	switch(flashMode)
	{
		case 0: return nil;
		default: return NSLocalizedString(@"Unknown flash mode", nil);
		case 0x0001: return NSLocalizedString(@"Flash fired", nil);
		//{ 0x0005, @"Strobe return light not detected";
		//{ 0x0007, @"Strobe return light detected";
		case 0x0009: return NSLocalizedString(@"Flash fired, compulsory mode", nil);
		case 0x000D: return NSLocalizedString(@"Flash fired, compulsory mode", nil);
		case 0x000F: return NSLocalizedString(@"Flash fired, compulsory mode", nil);
		case 0x0010: return NSLocalizedString(@"Flash not fired, compulsory mode", nil);
		case 0x0018: return NSLocalizedString(@"Flash not fired, auto mode", nil);
		case 0x0019: return NSLocalizedString(@"Flash fired, auto mode", nil);
		case 0x001D: return NSLocalizedString(@"Flash fired, auto mode", nil);
		case 0x001F: return NSLocalizedString(@"Flash fired, auto mode", nil);
		case 0x0020: return NSLocalizedString(@"No flash function", nil);
		case 0x0041: return NSLocalizedString(@"Flash fired, red-eye mode", nil);
		case 0x0045: return NSLocalizedString(@"Flash fired, red-eye mode", nil);
		case 0x0047: return NSLocalizedString(@"Flash fired, red-eye mode", nil);
		case 0x0049: return NSLocalizedString(@"Flash fired, compulsory mode", nil);
		case 0x004D: return NSLocalizedString(@"Flash fired, compulsory mode", nil);
		case 0x004F: return NSLocalizedString(@"Flash fired, compulsory mode", nil);
		case 0x0059: return NSLocalizedString(@"Flash fired, auto & red-eye modes", nil);
		case 0x005D: return NSLocalizedString(@"Flash fired, auto & red-eye modes", nil);	 
	}

	return nil;
}

//{ 0x0000, @"Flash did not fire" },
//{ 0x0001, @"Flash fired" },
//{ 0x0005, @"Strobe return light not detected" },
//{ 0x0007, @"Strobe return light detected" },
//{ 0x0009, @"Flash fired, compulsory flash mode" },
//{ 0x000D, @"Flash fired, compulsory flash mode, return light not detected" },
//{ 0x000F, @"Flash fired, compulsory flash mode, return light detected" },
//{ 0x0010, @"Flash did not fire, compulsory flash mode" },
//{ 0x0018, @"Flash did not fire, auto mode" },
//{ 0x0019, @"Flash fired, auto mode" },
//{ 0x001D, @"Flash fired, auto mode, return light not detected" },
//{ 0x001F, @"Flash fired, auto mode, return light detected" },
//{ 0x0020, @"No flash function" },
//{ 0x0041, @"Flash fired, red-eye reduction mode" },
//{ 0x0045, @"Flash fired, red-eye reduction mode, return light not detected" },
//{ 0x0047, @"Flash fired, red-eye reduction mode, return light detected" },
//{ 0x0049, @"Flash fired, compulsory flash mode, red-eye reduction mode" },
//{ 0x004D, @"Flash fired, compulsory flash mode, red-eye reduction mode, return light not detected" },
//{ 0x004F, @"Flash fired, compulsory flash mode, red-eye reduction mode, return light detected" },
//{ 0x0059, @"Flash fired, auto mode, red-eye reduction mode" },
//{ 0x005D, @"Flash fired, auto mode, return light not detected, red-eye reduction mode" },


- (void) _addExifExifData:(GtTableViewLayoutBuilder*) builder dataSourceManager:(GtDataSourceManager*) dataSourceManager exifDictionary:(NSDictionary*) exifDict
{
	[dataSourceManager setDataSource:GtReturnAutoreleased([exifDict mutableCopy]) forKey:(NSString*)kCGImagePropertyExifDictionary];

	if( [exifDict objectForKey:(NSString*)kCGImagePropertyExifDateTimeOriginal])
	{
		[builder addCell:[GtWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell:NSLocalizedString(@"Date Taken", nil) value:nil] forKey:GtKeyPathStringMake((NSString*)kCGImagePropertyExifDictionary, (NSString*)kCGImagePropertyExifDateTimeOriginal)];
		builder.cell.formatterClass = [GtDateFormatter class];
	}

	if([exifDict objectForKey:(NSString*)kCGImagePropertyExifFocalLength])
	{
		[builder addCell:[GtWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell:NSLocalizedString(@"Focal Length", nil)] forKey:GtKeyPathStringMake((NSString*)kCGImagePropertyExifDictionary, (NSString*)kCGImagePropertyExifFocalLength)];
		builder.cell.formatterClass = [GtIntFormatter class];
	}
	
	id shutterSpeed = [exifDict objectForKey:(NSString*)kCGImagePropertyExifShutterSpeedValue];
	id fStop = [exifDict objectForKey:(NSString*)kCGImagePropertyExifFNumber];
	if(shutterSpeed && fStop)
	{
		[builder addCell:[GtWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell:NSLocalizedString(@"Exposure", nil)] forKey:@"exifExtras.Exposure"];
		float shutter = [shutterSpeed floatValue];
		float denominator = roundf(powf(2.0f, fabsf(shutter)));
		
		if(shutter > 0)
		{
			[dataSourceManager setObject:[NSString stringWithFormat:(NSLocalizedString(@"1/%.0f at f/%@", nil)), denominator, fStop]
				forKeyPath:@"exifExtras.Exposure"
				fireDataChangedEvent:NO];
		}
		else
		{
			[dataSourceManager setObject:[NSString stringWithFormat:(NSLocalizedString(@"%.0fs at f/%@", nil)), denominator, fStop]
				forKeyPath:@"exifExtras.Exposure"
				fireDataChangedEvent:NO];
		}
	}	 
	
	if([exifDict objectForKey:(NSString*)kCGImagePropertyExifISOSpeedRatings])
	{
		NSNumber* iso = [[exifDict objectForKey:(NSString*)kCGImagePropertyExifISOSpeedRatings] objectAtIndex:0];
		if(iso)
		{
			[builder addCell:[GtWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell:NSLocalizedString(@"ISO speed", nil)] forKey:@"exifExtras.ISO"];
			builder.cell.formatterClass = [GtIntFormatter class];
			[dataSourceManager setObject:[NSString stringWithFormat:(NSLocalizedString(@"ISO %@", nil)), [iso description]] forKeyPath:@"exifExtras.ISO" fireDataChangedEvent:NO];
		}
	}
	
	if([exifDict objectForKey:(NSString*)kCGImagePropertyExifFlash])
	{
		NSString* flashModeStr = [GtCameraExifTableViewBuilder flashModeStringFromFlashMode:[[exifDict objectForKey:(NSString*)kCGImagePropertyExifFlash] unsignedIntValue]];
		if(GtStringIsNotEmpty(flashModeStr))
		{
			[builder addCell:[GtWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell:NSLocalizedString(@"Flash", nil)] forKey:@"exifExtras.Flash"];
			[dataSourceManager setObject:flashModeStr forKeyPath:@"exifExtras.Flash" fireDataChangedEvent:NO];
		}
	}
 
}

- (void) photoMapViewController:(GtPhotoMapViewController*) controller beginLoadingPhotoAtIndex:(NSUInteger) idx
{
}

- (void) photoMapViewControllerDidFinishLoadingPhotos:(GtPhotoMapViewController*) controller
{
}

- (void) photoMapViewController:(GtPhotoMapViewController*) controller	photoWasSelected:(id) photo
{
}

- (void) showOnMap:(GtEditObjectTableViewCell*) row
{
	if(self.masterExif)
	{
		GtMasterPhotoExif* exif = GtReturnAutoreleased([[GtMasterPhotoExif alloc] initWithDictionary:self.masterExif]);
		
		GtPhotoMapViewController* controller = [[GtPhotoMapViewController alloc] init];
		[row.viewController.navigationController pushViewController:controller animated:YES];
		GtRelease(controller);
	
		[controller addPin:NSLocalizedString(@"Photo", @"Exif - name of pin when showing on map") coordinate:exif.gpsExif.coordinate];
	}
}

- (void) _addGpsExifData:(GtTableViewLayoutBuilder*) builder dataSourceManager:(GtDataSourceManager*) dataSourceManager exifDictionary:(NSDictionary*) exifDict
{
	if(DeviceIsPad())
	{
		[builder addCell:[GtWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell:NSLocalizedString(@"GPS Location", nil)] forKey:@"exifExtras.gps"];
	}
	else 
	{
		[builder addCell:[GtTwoLineLabelAndValueCell twoLineLabelAndValueCell: NSLocalizedString(@"GPS Location", nil)] forKey:@"exifExtras.gps"];
	}

	[dataSourceManager setObject:GtPrettyStringForCoordinate(GtCoordinateFromGpsExif(exifDict)) forKeyPath:@"exifExtras.gps" fireDataChangedEvent:NO];
	if(self.enableMapForGps)
	{
		builder.cell.wasSelectedCallback = GtCallbackMake(self, @selector( showOnMap:));
	}
}

- (void) constructExifRows:(GtTableViewLayoutBuilder*) builder dataSourceManager:(GtDataSourceManager*) dataSourceManager
{
	[dataSourceManager setDataSource:m_extras forKey:GtCameraExifExtrasDataSourceKey];
		
	if([self.masterExif objectForKey:(NSString*)kCGImagePropertyPixelWidth])
	{
		[builder addCell:[GtWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell:NSLocalizedString(@"Dimensions", nil)] forKey:GtCameraExifDimensionsExifKeyPath];
		NSString* dimensionsStr = [NSString stringWithFormat:(NSLocalizedString(@"%@ x %@", @"Exif dimensions")), 
					[self.masterExif objectForKey:(NSString*)kCGImagePropertyPixelWidth],
					[self.masterExif objectForKey:(NSString*)kCGImagePropertyPixelHeight]];
		
		[dataSourceManager setObject:dimensionsStr
			forKeyPath:GtCameraExifDimensionsExifKeyPath
			fireDataChangedEvent:NO];
	}
	
	NSDictionary* exifDict = [self.masterExif objectForKey:(NSString*) kCGImagePropertyExifDictionary];
	if(exifDict)
	{
		[self _addExifExifData:builder dataSourceManager:dataSourceManager exifDictionary:exifDict];
	}
	
	NSDictionary* tiffDict = [self.masterExif objectForKey:(NSString*) kCGImagePropertyTIFFDictionary];
	if(tiffDict)
	{
		[self _addTiffData:builder dataSourceManager:dataSourceManager exifDictionary:tiffDict];
	}
	
//	  [builder addCell];
//	  builder.cell.label = @"Color space";
//	  builder.cell = [GtWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell]; 
//	  NSString* colorSpace = [exif objectForKey:(NSString*)kCGImagePropertyColorModel];
//	  [builder.cell setText:colorSpace];
	
	NSDictionary* gpsDict = [self.masterExif objectForKey:(NSString*)kCGImagePropertyGPSDictionary];
	if(gpsDict)
	{	
		[self _addGpsExifData:builder dataSourceManager:dataSourceManager exifDictionary:gpsDict];
	}
}					 


- (void) willConstructWithTableLayoutBuilder:(GtTableViewLayoutBuilder*) builder
{
	m_builder = [[GtTableViewLayoutBuilder alloc] initWithTableLayout:builder.tableLayout];
	m_builder.section = builder.section;
	if(!m_builder.section)
	{
		[builder addSection:@"exif"];
	}
}

- (void) doUpdateDataSourceManager:(GtDataSourceManager*) dataSourceManager
{
	for(GtEditObjectTableViewCell* row in m_builder.cells)
	{
		[row.parentSection removeCell:row];
	}

	if(self.masterExif)
	{
		[self constructExifRows:m_builder dataSourceManager:dataSourceManager];
	}
	
	if(m_overrides)
	{
		for(NSString* keyPath in m_overrides)
		{
			[dataSourceManager setObject:[m_overrides objectForKey:keyPath] forKeyPath:keyPath fireDataChangedEvent:NO];
		}
	}
}
@end

