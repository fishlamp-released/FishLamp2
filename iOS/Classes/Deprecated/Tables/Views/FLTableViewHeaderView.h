//
//	FLTableViewHeaderView.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/25/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLTableViewHeaderView : UIView {
@private
	UILabel* _label;
	CGFloat _indent;
}

@property (readwrite, assign, nonatomic) CGFloat textIndent;
@property (readwrite, retain, nonatomic) UILabel* textLabel;

- (CGFloat) minHeight;

@end
