//
//	FLTableViewCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/29/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLEditObjectTableViewCell.h"
#import "FLDisplayFormatter.h"
#import "FLLegacyDataSource.h"
//#import "FLTableViewCellBackgroundView.h"

#import "FLDisplayFormatter.h"
#import "FLTableViewTab.h"
#import "FLTableViewSection.h"

#define kNilKeyPrefix @"nilkey_"

@implementation FLEditObjectTableViewCell

@synthesize dataSource = _dataSource;
@synthesize dataKeyPath = _dataKeyPath;
@synthesize rowKey = _rowKey;
@synthesize formatterClass = _formatterClass;
@synthesize parentSection = _parent;
@synthesize maxDataSize = _maxDataSize;
@synthesize viewController = _viewController;
@synthesize helpText = _helpText;
@synthesize wasSelectedCallback = _selectedCallback;
@synthesize accessoryWasTappedCallback = _accessoryTappedCallback;
@synthesize willReloadCallback = _willReloadCallback;
@synthesize dataIsLoaded = _dataIsLoaded; 

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
        static NSInteger s_counter = 0;
        self.dataKeyPath = [NSString stringWithFormat:@"%@_%d", kNilKeyPrefix, ++s_counter];
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		_dataIsLoaded = YES;
	}
	
	return self;
}

- (void) dealloc
{
	FLRelease(_helpText);
	FLRelease(_rowKey);
	FLRelease(_dataKeyPath);
	FLSuperDealloc();
}

- (BOOL) hasDataKey
{
    return ![self.dataKeyPath hasPrefix:kNilKeyPrefix];
}

- (void) setDataIsLoaded:(BOOL) dataIsLoaded
{
	if(dataIsLoaded != _dataIsLoaded)
	{
		_dataIsLoaded = dataIsLoaded;
		[self enabledStateDidChange];
	}
}

- (FLTableViewLayout*) parentLayout
{
	return _parent.parentTab.parentLayout;
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
	[self applyThemeIfNeeded];
}

- (id) dataSourceObject
{
    FLAssertIsNotNil(_dataSource);

	return [_dataSource tableViewCellGetCellData:self];
}

- (void) setDataSourceObject:(id) object
{
	[_dataSource tableViewCell:self setCellData:object];

//	  [self.dataSource setObject:object forKeyPath:self.dataKeyPath fireDataChangedEvent:YES];
}

- (NSString*) displayStringFromValue:(id) value
{
	if(_formatterClass)
	{
        NSString* outString = [_formatterClass displayFormatterDataToString:value];
		if(outString)
        {
            return outString;
        }
	}
    
    return [value formattedStringForDisplay];
}

- (id) valueFromDisplayString:(NSString*) inData
{
	if(_formatterClass)
	{
		return [_formatterClass displayFormatterStringToData:inData];
	}

	return inData;
}

- (void) setFormattedDisplayString:(NSString*) string
{
	id formattedObjOrString = string;
	
	if(_dataSource)
	{
		 formattedObjOrString = [self valueFromDisplayString:string];
//		   [self.rowData.formatterClass displayFormatterStringToData:string];
	}
	
	self.dataSourceObject = formattedObjOrString;
}

- (NSString*) formattedDisplayString
{
	id stringOrObj = self.dataSourceObject;
	
	if(_dataSource)
	{
		 stringOrObj = [self displayStringFromValue:stringOrObj];
//		   [self.rowData.formatterClass displayFormatterDataToString:stringOrObj];
	}

	return stringOrObj != nil ? stringOrObj : @""; 
}

- (void) prepareForDestruction
{
    
    _willReloadCallback = FLCallbackZero;
	_selectedCallback = FLCallbackZero;
	_accessoryTappedCallback = FLCallbackZero;
	[self clearDelegates];
}

@end


