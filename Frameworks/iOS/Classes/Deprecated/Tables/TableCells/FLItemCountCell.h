//
//	FLItemCountCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/17/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FLItemCountCellHeight 60

@protocol FLItemCountCellDelegate;

@interface FLItemCountCell : UITableViewCell {
@private
	NSInteger _count;
	NSInteger _total;
	NSString* _itemName;
	UILabel* _label;
	UIActivityIndicatorView* _spinner;
	UILabel* _bottomLabel;
	__unsafe_unretained id<FLItemCountCellDelegate> _itemCountDelegate;
}

@property (readwrite, assign, nonatomic) id<FLItemCountCellDelegate> itemCountCellDelegate;
@property (readwrite, retain, nonatomic) NSString* actionItemName;
@property (readwrite, assign, nonatomic) NSInteger count;
@property (readwrite, assign, nonatomic) NSInteger total;

@property (readonly, retain, nonatomic) UILabel* bottomLabel;

- (void) startSpinner;
- (void) stopSpinner;
- (BOOL) isSpinning;

- (void) setTextColor:(UIColor*) textColor shadowTextColor:(UIColor*) shadowColor;

@end
@protocol FLItemCountCellDelegate <NSObject>
- (void) itemCountCellNeedsLoading:(FLItemCountCell*) cell;
@end