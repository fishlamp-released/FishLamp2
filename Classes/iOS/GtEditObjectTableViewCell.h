//
//	GtTableViewCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/29/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtWeakReference.h"
#import "GtLabel.h"
#import "GtTableViewCell.h"
@class GtTableViewSection;
@class GtTableViewLayout;

@protocol GtTableViewCellDataSource;

@class GtEditObjectTableViewCell;

@interface GtEditObjectTableViewCell : GtTableViewCell {
@private
	id<GtTableViewCellDataSource> m_dataSource;
	NSString* m_dataKeyPath;
	id m_rowKey;
	NSString* m_helpText;
	GtCallback m_selectedCallback;
	GtCallback m_accessoryTappedCallback;
	GtCallback m_willReloadCallback;
	Class m_formatterClass;
	GtTableViewSection* m_parent;
	UIViewController* m_viewController;
	NSUInteger m_maxDataSize;
	struct {
		unsigned int dataIsLoaded:1;
	} m_tableCellFlags; 
}

@property (readwrite, assign, nonatomic) GtCallback wasSelectedCallback;
@property (readwrite, assign, nonatomic) GtCallback accessoryWasTappedCallback;
@property (readwrite, assign, nonatomic) GtCallback willReloadCallback;
@property (readwrite, assign, nonatomic) NSUInteger maxDataSize;

// misc helpers
@property (readwrite, assign, nonatomic) GtTableViewSection* parentSection;
@property (readonly, assign, nonatomic) GtTableViewLayout* parentLayout;

@property (readwrite, assign, nonatomic) id<GtTableViewCellDataSource> dataSource;

@property (readonly, assign, nonatomic) BOOL canEditData; // loaded and enabled.
@property (readwrite, assign, nonatomic) BOOL dataIsLoaded;

@property (readwrite, retain, nonatomic) NSString* dataKeyPath;
@property (readwrite, retain, nonatomic) NSString* rowKey;

- (void) updateCellState;

// convienience methods for pushing/pulling data from dataSource

@property (readonly, assign, nonatomic) BOOL hasDataKey;

@property (readwrite, retain, nonatomic) id dataSourceObject;
@property (readwrite, retain, nonatomic) NSString* formattedDisplayString;

@property (readwrite, retain, nonatomic) NSString* helpText;

@property (readwrite, assign, nonatomic) UIViewController* viewController;
@property (readwrite, assign, nonatomic) Class formatterClass;

- (void) clearDelegates;
- (void) prepareForDestruction;

@end

@protocol GtTableViewCellDataSource	 <NSObject>
- (id) tableViewCellGetCellData:(GtEditObjectTableViewCell*) cell;
- (void) tableViewCell:(GtEditObjectTableViewCell*) cell setCellData:(id) object;
@end
