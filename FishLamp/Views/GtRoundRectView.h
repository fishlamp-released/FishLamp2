//
//  GtRoundRectView.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/25/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GtRoundRectView : UIView {
@private
	CGFloat m_backgroundOpacity;
	CGFloat m_borderOpacity;
	UIColor* m_backgroundColor;
	UIColor* m_outlineColor;
}

@property (readwrite, assign, nonatomic) CGFloat backgroundOpacity;
@property (readwrite, assign, nonatomic) CGFloat borderOpacity;

@property (readwrite, retain, nonatomic) UIColor* optionalBackgroundColor;
@property (readwrite, retain, nonatomic) UIColor* outlineColor;

- (void) setDefaults;

@end
