//
//	FLSegmentedControlCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLEditObjectTableViewCell.h"

@interface FLSegmentedControlCell : FLEditObjectTableViewCell {
@private
	UISegmentedControl* _control;
}

@property (readonly, retain, nonatomic) UISegmentedControl* segmentedControl;

- (id) initWithSegmentedControlStyle:(UISegmentedControlStyle) style items:(NSArray*) items;

+ (FLSegmentedControlCell*) segmentedControlCell:(UISegmentedControlStyle) style items:(NSArray*) items;

@end
