//
//	GtTableViewCellDisclosureRectangle.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/7/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtWidget.h"

@interface GtTableViewCellAccessoryWidget : GtWidget {
@private
	UIColor* m_color;
	UIColor* m_highlightedColor;
	NSString* m_check;
	UIFont* m_font;
	UITableViewCellAccessoryType m_type;
	CGFloat m_checkmarkSize;
}

@property (readwrite, assign, nonatomic) UITableViewCellAccessoryType type;
@property (readwrite, retain, nonatomic) UIColor* color;
@property (readwrite, retain, nonatomic) UIColor* highlightedColor;
@property (readwrite, assign, nonatomic) CGFloat checkmarkSize;

- (void) resizeToAccessorySize;

@end
