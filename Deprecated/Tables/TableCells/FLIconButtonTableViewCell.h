//
//	FLIconButtonTableCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/27/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLEditObjectTableViewCell.h"
#import "FLCallbackObject.h"

@interface FLIconButtonTableViewCell : FLEditObjectTableViewCell {
	FLCallback _callback;
	UIImage* _icon;
	UIImageView* _iconImageView;
}

@property (readwrite, retain, nonatomic) UIImage* icon;

- (void) setCallback:(id) target action:(SEL) action;



@end
