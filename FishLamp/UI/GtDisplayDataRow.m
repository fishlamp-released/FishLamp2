//
//  GtDisplayDataRow.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/20/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtDisplayDataRow.h"
#import "GtColors.h"
#import "GtEditableDataProtocol.h"
#import "GtObjectEditHandler.h"
#import "GtDisplayDataGroup.h"
#import "GtTableViewCell.h"

@implementation GtDisplayDataRow

GtSynthesizeStructProperty(committing, setCommitting, BOOL, m_flags);
GtSynthesizeStructProperty(editing, setEditing, BOOL, m_flags);
GtSynthesizeStructProperty(isEditable, setIsEditable, BOOL, m_flags);

@synthesize cellConfigureAction = m_cellConfigureAction;
@synthesize cellClass = m_cellClass;
@synthesize panelConfigureAction = m_panelConfigureAction;
@synthesize panelClass = m_panelClass;
@synthesize formatterClass = m_formatterClass;
@synthesize parentGroup = m_parent;
@synthesize dataSource = m_dataSource;
@synthesize maxDataSize = m_maxDataSize;

GtSynthesizeSetter(setCell, UITableViewCell*, m_cell); // getter defined belowe
GtSynthesize(label, setLabel, NSString, m_label);
GtSynthesize(helpText, setHelpText, NSString, m_helpText);
GtSynthesizeID(rowId, setRowId);
GtSynthesizeID(key, setKey);
GtSynthesizeID(cellData, setCellData);

- (void) dealloc
{
    GtRelease(m_cell);
	GtRelease(m_label);
	GtRelease(m_helpText);
	GtRelease(m_rowId);
	GtRelease(m_key);
	GtRelease(m_cellData);
	
	[super dealloc];
}


- (id) init
{
	if(self = [super init])
	{
        self.isEditable = YES;
	}
	
	return self;
}

- (id) initWithDataSourceAndKey:(id<GtDisplayDataRowDataSource>) dataSource 
							key:(id) key
{
	if(self = [super init])
	{
		self.dataSource = dataSource;
		self.key = key;
		self.rowId = key;
        self.isEditable = YES;
	}
	
	return self;
}

- (GtObjectEditHandler*) parentHandler
{
	return m_parent.parentHandler;
}

- (UITableViewCell*) cell
{
	if(!m_cell)
	{
		m_cell = [GtAlloc(m_cellClass) initWithFrame:CGRectZero reuseIdentifier:nil];
	}
	
	return m_cell;
}

- (id) data
{
	if(m_dataSource)
	{
		return [m_dataSource displayDataRow:self getDataForRow:self.key];
	}
	
	return nil;
}

- (void) setData:(id) data
{
	if(m_dataSource)
	{
		[m_dataSource displayDataRow:self setDataForRow:self.key data:data];
	}
}

- (void) setCellInfo:(Class) cellClass configureAction:(SEL) configureSelector
{
	m_cellClass = cellClass;
	m_cellConfigureAction = configureSelector;
}

- (void) setPanelInfo:(Class) panelClass configureAction:(SEL) configureSelector
{
	m_panelClass = panelClass;
	m_panelConfigureAction = configureSelector;
}

- (NSString*) displayStringFromValue
{
	if(m_formatterClass)
	{
        if([m_formatterClass respondsToSelector:@selector(instance)])
        {
            return [[m_formatterClass performSelector:@selector(instance)] dataToString:self.data];
        }
        else
        {
            id<GtDisplayFormatterProtocol> formatter = [GtAlloc(m_formatterClass) init];
            NSString* outValue = [formatter dataToString:self.data];
            GtRelease(formatter);
		
            return outValue;
        }
	}

	return self.data;
}

- (void) setValueWithDisplayString:(NSString*) displayString
{
	self.data = [self getDataFromStringDisplay:displayString];
}

- (id) getDataFromStringDisplay:(NSString*) inData
{
	if(m_formatterClass)
	{
		id<GtDisplayFormatterProtocol> formatter = [GtAlloc(m_formatterClass) init];
		id outValue = [formatter stringToData:inData prevData:self.data];
		GtRelease(formatter);
		return outValue;
	}

	return inData;
}

- (NSString*) description
{
	return @"blarg!!!1!";
}

- (CGFloat) textHeight:(UIFont*) font
	areaSize:(CGSize) areaSize
{
	NSString* text = [self displayStringFromValue];
	
	if(text)
	{
		CGSize size = [text sizeWithFont:font constrainedToSize:areaSize
					lineBreakMode:UILineBreakModeWordWrap];
					
		return size.height; 
	}		

	return 0;

}

+ (CGFloat) defaultCellWidth
{
	return 260;
}

- (CGFloat) textHeight
{
	return [self	textHeight:[UIFont standardTextFieldFont] 
						areaSize:CGSizeMake([GtDisplayDataRow defaultCellWidth], 5000)];
}

@end

@implementation GtSimpleDisplayDataRow

GtSynthesizeID(data, setData);

- (id) init
{
	if(self = [super init])
	{
	}
	
	return self;
}

- (id) initWithRowData:(id) data
{
	if(self = [super init])
	{
		self.data = data;
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_data);
	[super dealloc];
}




@end