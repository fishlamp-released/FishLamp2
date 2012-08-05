//
//	FLTableViewCellDisclosureRectangle.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/7/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLWidget.h"

@interface FLTableViewCellAccessoryWidget : FLWidget {
}

@property (readwrite, assign, nonatomic) CGFloat arrowSize;
@property (readwrite, assign, nonatomic) CGFloat arrowLineSize;

@property (readwrite, assign, nonatomic) UITableViewCellAccessoryType type;
@property (readwrite, retain, nonatomic) UIColor* color;
@property (readwrite, retain, nonatomic) UIColor* highlightedColor;
@property (readwrite, retain, nonatomic) UIColor* selectedColor;
@property (readwrite, assign, nonatomic) CGFloat checkmarkSize;

- (void) resizeToAccessorySize;

@end
