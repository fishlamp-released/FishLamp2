//
//	GtItemCountCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/17/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#define GtItemCountCellHeight 60

@protocol GtItemCountCellDelegate;

@interface GtItemCountCell : UITableViewCell {
@private
	NSInteger m_count;
	NSInteger m_total;
	NSString* m_itemName;
	UILabel* m_label;
	UIActivityIndicatorView* m_spinner;
	UILabel* m_bottomLabel;
	id<GtItemCountCellDelegate> m_itemCountDelegate;
}

@property (readwrite, assign, nonatomic) id<GtItemCountCellDelegate> itemCountCellDelegate;
@property (readwrite, retain, nonatomic) NSString* itemName;
@property (readwrite, assign, nonatomic) NSInteger count;
@property (readwrite, assign, nonatomic) NSInteger total;

@property (readonly, retain, nonatomic) UILabel* bottomLabel;

- (void) startSpinner;
- (void) stopSpinner;
- (BOOL) isSpinning;

- (void) setTextColor:(UIColor*) textColor shadowTextColor:(UIColor*) shadowColor;

@end
@protocol GtItemCountCellDelegate <NSObject>
- (void) itemCountCellNeedsLoading:(GtItemCountCell*) cell;
@end