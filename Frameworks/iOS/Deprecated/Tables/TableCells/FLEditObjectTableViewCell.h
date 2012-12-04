//
//	FLTableViewCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/29/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLTableViewCell.h"

@class FLTableViewSection;
@class FLTableViewLayout;

@protocol FLTableViewCellDataSource;

@class FLEditObjectTableViewCell;

@interface FLEditObjectTableViewCell : FLTableViewCell {
@private
	__unsafe_unretained id<FLTableViewCellDataSource> _dataSource;
	__unsafe_unretained FLTableViewSection* _parent;
	__unsafe_unretained UIViewController* _viewController;
	NSString* _dataKeyPath;
	id _rowKey;
	NSString* _helpText;
	FLCallback_t _selectedCallback;
	FLCallback_t _accessoryTappedCallback;
	FLCallback_t _willReloadCallback;
	Class _formatterClass;
    NSUInteger _maxDataSize;
	BOOL _dataIsLoaded;
}

@property (readwrite, assign, nonatomic) FLCallback_t wasSelectedCallback;
@property (readwrite, assign, nonatomic) FLCallback_t accessoryWasTappedCallback;
@property (readwrite, assign, nonatomic) FLCallback_t willReloadCallback;
@property (readwrite, assign, nonatomic) NSUInteger maxDataSize;

// misc helpers
@property (readwrite, assign, nonatomic) FLTableViewSection* parentSection;
@property (readonly, assign, nonatomic) FLTableViewLayout* parentLayout;

@property (readwrite, assign, nonatomic) id<FLTableViewCellDataSource> dataSource;

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

@protocol FLTableViewCellDataSource	 <NSObject>
- (id) tableViewCellGetCellData:(FLEditObjectTableViewCell*) cell;
- (void) tableViewCell:(FLEditObjectTableViewCell*) cell setCellData:(id) object;
@end
