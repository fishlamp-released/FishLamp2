//
//  FLThemeChooserViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/7/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLThemeChooserViewController.h"
#import "FLThemeManager.h"
#import "FLCheckMarkGroup.h"

@implementation FLThemeChooserViewController

- (id) init
{
	if((self = [super init]))
	{
//		_savedThemeInfo = FLRetain([[FLThemeManager instance] loadSavedThemeInfo]);
//		[self.dataSourceManager setDataSource:_savedThemeInfo forKey:[FLSavedThemeInfo dataSourceKey]];
	}
	return self;
}

- (void) dealloc 
{
	FLRelease(_savedThemeInfo);
	FLSuperDealloc();
}

- (BOOL) didChangeDataForKey:(id)key previousValue:(id)previousValue
{
//	[[FLThemeManager instance] saveThemeInfo:_savedThemeInfo];
//	[[FLThemeManager instance] setThemeWithThemeInfo:_savedThemeInfo];

	return [super didChangeDataForKey:key previousValue:previousValue];
	
}

- (void) willConstructWithTableLayoutBuilder:(FLTableViewLayoutBuilder*) builder
{
//	[builder addSection].title = NSLocalizedString(@"Theme", nil);
//	
//	FLCheckMarkGroup* group1 = [FLCheckMarkGroup checkMarkTableCellGroup:[FLSavedThemeInfo keyPathWithDataKey:[FLSavedThemeInfo classNameKey]]];
//	[builder addCell: [group1 addRowWithTitle:NSLocalizedString(@"Dark", nil) value:@"ZfDarkTheme" isChecked:YES]];
//	[builder addCell: [group1 addRowWithTitle:NSLocalizedString(@"Silver", nil) value:@"ZfSilverTheme" isChecked:NO]];
//	
//	
//	[builder addSection].title = NSLocalizedString(@"Text Size", nil);
//	
//	FLCheckMarkGroup* group2 = [FLCheckMarkGroup checkMarkTableCellGroup:[FLSavedThemeInfo keyPathWithDataKey:[FLSavedThemeInfo fontSizeKey]]];
//	[builder addCell: [group2 addRowWithTitle:NSLocalizedString(@"Small", nil) value:[NSNumber numberWithInt:FLThemeTextSizeSmall] isChecked:YES]];
//	[builder addCell: [group2 addRowWithTitle:NSLocalizedString(@"Normal", nil) value:[NSNumber numberWithInt:FLThemeTextSizeMedium] isChecked:NO]];
//	[builder addCell: [group2 addRowWithTitle:NSLocalizedString(@"Large", nil) value:[NSNumber numberWithInt:FLThemeTextSizeLarge] isChecked:NO]];
		
}

@end
