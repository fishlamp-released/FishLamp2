//
//	GtIconButtonTableCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/27/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtEditObjectTableViewCell.h"
#import "GtCallbackObject.h"

@interface GtIconButtonTableViewCell : GtEditObjectTableViewCell {
	GtCallback m_callback;
	UIImage* m_icon;
	UIImageView* m_imageView;
}

@property (readwrite, retain, nonatomic) UIImage* icon;

- (void) setCallback:(id) target action:(SEL) action;



@end
