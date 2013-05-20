//
//  GtThemeChooserViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/7/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtThemeChooserViewController.h"
#import "GtThemeManager.h"
#import "GtCheckMarkGroup.h"

@implementation GtThemeChooserViewController

- (id) init
{
	if((self = [super init]))
	{
		m_savedThemeInfo = GtRetain([[GtThemeManager instance] loadSavedThemeInfo]);
		[self.dataSourceManager setDataSource:m_savedThemeInfo forKey:[GtSavedThemeInfo dataSourceKey]];
	}
	return self;
}

- (void) dealloc 
{
	GtRelease(m_savedThemeInfo);
	GtSuperDealloc();
}

- (BOOL) didChangeDataForKey:(id)key previousValue:(id)previousValue
{
	[[GtThemeManager instance] saveThemeInfo:m_savedThemeInfo];
	[[GtThemeManager instance] setThemeWithThemeInfo:m_savedThemeInfo];

	return [super didChangeDataForKey:key previousValue:previousValue];
	
}

- (void) willConstructWithTableLayoutBuilder:(GtTableViewLayoutBuilder*) builder
{
	[builder addSection].title = NSLocalizedString(@"Theme", nil);
	
	GtCheckMarkGroup* group1 = [GtCheckMarkGroup checkMarkTableCellGroup:[GtSavedThemeInfo keyPathWithDataKey:[GtSavedThemeInfo classNameKey]]];
	[builder addCell: [group1 addRowWithTitle:NSLocalizedString(@"Dark", nil) value:@"ZfDarkTheme" isChecked:YES]];
	[builder addCell: [group1 addRowWithTitle:NSLocalizedString(@"Silver", nil) value:@"ZfSilverTheme" isChecked:NO]];
	
	
	[builder addSection].title = NSLocalizedString(@"Text Size", nil);
	
	GtCheckMarkGroup* group2 = [GtCheckMarkGroup checkMarkTableCellGroup:[GtSavedThemeInfo keyPathWithDataKey:[GtSavedThemeInfo fontSizeKey]]];
	[builder addCell: [group2 addRowWithTitle:NSLocalizedString(@"Small", nil) value:[NSNumber numberWithInt:GtThemeTextSizeSmall] isChecked:YES]];
	[builder addCell: [group2 addRowWithTitle:NSLocalizedString(@"Normal", nil) value:[NSNumber numberWithInt:GtThemeTextSizeMedium] isChecked:NO]];
	[builder addCell: [group2 addRowWithTitle:NSLocalizedString(@"Large", nil) value:[NSNumber numberWithInt:GtThemeTextSizeLarge] isChecked:NO]];
		
}

@end
