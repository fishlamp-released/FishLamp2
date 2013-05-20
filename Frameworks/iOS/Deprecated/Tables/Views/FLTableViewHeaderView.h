//
//	FLTableViewHeaderView.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/25/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
