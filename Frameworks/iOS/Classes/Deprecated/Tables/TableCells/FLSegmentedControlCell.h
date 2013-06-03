//
//	FLSegmentedControlCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
