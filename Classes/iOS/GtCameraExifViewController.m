//
//	GtCameraExifViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/18/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCameraExifViewController.h"

@implementation GtCameraExifViewController

@synthesize exifBuilder = m_exifBuilder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		if(OSVersionIsAtLeast4_1())
		{	
			m_exifBuilder = [[GtCameraExifTableViewBuilder alloc] init];
		}
		self.buttonStrategy = GtEditObjectViewControllerShowButtonsWhenEdited;
	}

	return self;
}

- (id) init
{
	if((self = [self initWithNibName:@"GtCameraExif" bundle:nil]))
	{
		self.title = NSLocalizedString(@"Photo Exif", nil);
	}

	return self;
}

- (void) willConstructWithTableLayoutBuilder:(GtTableViewLayoutBuilder*) builder
{
}

- (void) doUpdateDataSourceManager:(GtDataSourceManager*) dataSourceManager
{
	if(OSVersionIsAtLeast4_1())
	{
		[m_exifBuilder doUpdateDataSourceManager:dataSourceManager];
	}
}

- (void) dealloc
{
	GtRelease(m_exifBuilder);
	GtSuperDealloc();
}

@end