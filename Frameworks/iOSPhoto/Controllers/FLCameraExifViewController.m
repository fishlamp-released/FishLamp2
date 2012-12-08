//
//	FLCameraExifViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/18/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCameraExifViewController.h"

@implementation FLCameraExifViewController

@synthesize exifBuilder = _exifBuilder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		_exifBuilder = [[FLCameraExifTableViewBuilder alloc] init];
		self.buttonStrategy = FLEditObjectViewControllerShowButtonsWhenEdited;
	}

	return self;
}

- (id) init
{
	if((self = [self initWithNibName:@"FLCameraExif" bundle:nil]))
	{
		self.title = NSLocalizedString(@"Photo Exif", nil);
	}

	return self;
}

- (void) willConstructWithTableLayoutBuilder:(FLTableViewLayoutBuilder*) builder
{
}

- (void) doUpdateDataSourceManager:(FLLegacyDataSource*) dataSourceManager
{
	if(OSVersionIsAtLeast4_1())
	{
		[_exifBuilder doUpdateDataSourceManager:dataSourceManager];
	}
}

- (void) dealloc
{
	FLRelease(_exifBuilder);
	super_dealloc_();
}

@end