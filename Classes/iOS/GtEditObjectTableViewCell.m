//
//	GtTableViewCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/29/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtEditObjectTableViewCell.h"
#import "GtDisplayFormatter.h"
#import "GtDataSource.h"
//#import "GtTableViewCellBackgroundView.h"

#import "GtDisplayFormatter.h"
#import "GtTableViewTab.h"
#import "GtTableViewSection.h"

#define kNilKeyPrefix @"nilkey_"

@implementation GtEditObjectTableViewCell

@synthesize dataSource = m_dataSource;
@synthesize dataKeyPath = m_dataKeyPath;
@synthesize rowKey = m_rowKey;
@synthesize formatterClass = m_formatterClass;
@synthesize parentSection = m_parent;
@synthesize maxDataSize = m_maxDataSize;
@synthesize viewController = m_viewController;
@synthesize helpText = m_helpText;
@synthesize wasSelectedCallback = m_selectedCallback;
@synthesize accessoryWasTappedCallback = m_accessoryTappedCallback;
@synthesize willReloadCallback = m_willReloadCallback;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
        static NSInteger s_counter = 0;
        self.dataKeyPath = [NSString stringWithFormat:@"%@_%d", kNilKeyPrefix, ++s_counter];
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		m_tableCellFlags.dataIsLoaded = YES;
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_helpText);
	GtRelease(m_rowKey);
	GtRelease(m_dataKeyPath);
	GtSuperDealloc();
}

- (BOOL) hasDataKey
{
    return ![self.dataKeyPath hasPrefix:kNilKeyPrefix];
}

- (BOOL) dataIsLoaded
{
	return m_tableCellFlags.dataIsLoaded;
}	

- (void) setDataIsLoaded:(BOOL) dataIsLoaded
{
	if(dataIsLoaded != m_tableCellFlags.dataIsLoaded)
	{
		m_tableCellFlags.dataIsLoaded = dataIsLoaded;
		[self enabledStateDidChange];
	}
}

- (GtTableViewLayout*) parentLayout
{
	return m_parent.parentTab.parentLayout;
}

- (void) clearDelegates
{
	self.dataSource = nil;
}

- (BOOL) canEditData
{
	return !self.disabled && self.dataIsLoaded;
}

- (void) updateCellState
{
	[self applyTheme];
}

- (id) dataSourceObject
{
    GtAssertNotNil(m_dataSource);

	return [m_dataSource tableViewCellGetCellData:self];
}

- (void) setDataSourceObject:(id) object
{
	[m_dataSource tableViewCell:self setCellData:object];

//	  [self.dataSource setObject:object forKeyPath:self.dataKeyPath fireDataChangedEvent:YES];
}

- (NSString*) displayStringFromValue:(id) value
{
	if(m_formatterClass)
	{
        NSString* outString = [m_formatterClass displayFormatterDataToString:value];
		if(outString)
        {
            return outString;
        }
	}
    
    return [value formattedStringForDisplay];
}

- (id) valueFromDisplayString:(NSString*) inData
{
	if(m_formatterClass)
	{
		return [m_formatterClass displayFormatterStringToData:inData];
	}

	return inData;
}

- (void) setFormattedDisplayString:(NSString*) string
{
	id formattedObjOrString = string;
	
	if(m_dataSource)
	{
		 formattedObjOrString = [self valueFromDisplayString:string];
//		   [self.rowData.formatterClass displayFormatterStringToData:string];
	}
	
	self.dataSourceObject = formattedObjOrString;
}

- (NSString*) formattedDisplayString
{
	id stringOrObj = self.dataSourceObject;
	
	if(m_dataSource)
	{
		 stringOrObj = [self displayStringFromValue:stringOrObj];
//		   [self.rowData.formatterClass displayFormatterDataToString:stringOrObj];
	}

	return stringOrObj != nil ? stringOrObj : @""; 
}

- (void) prepareForDestruction
{
    
    m_willReloadCallback = GtCallbackZero;
	m_selectedCallback = GtCallbackZero;
	m_accessoryTappedCallback = GtCallbackZero;
	[self clearDelegates];
}

@end


