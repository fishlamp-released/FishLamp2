//
//  GtIconButtonTableCell.h
//  MyZen
//
//  Created by Mike Fullerton on 12/27/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtTableViewCell.h"
#import "GtSimpleCallback.h"

@interface GtIconButtonTableViewCell : GtTableViewCell {
	GtSimpleCallback* m_callback;
	UIImage* m_icon;
	UIImageView* m_imageView;
}

@property (readwrite, assign, nonatomic) UIImage* icon;

- (void) setCallback:(id) target action:(SEL) action;



@end
