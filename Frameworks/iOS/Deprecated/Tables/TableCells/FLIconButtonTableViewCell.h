//
//	FLIconButtonTableCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/27/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLEditObjectTableViewCell.h"
#import "FLCallbackObject.h"

@interface FLIconButtonTableViewCell : FLEditObjectTableViewCell {
	FLCallback_t _callback;
	UIImage* _icon;
	UIImageView* _iconImageView;
}

@property (readwrite, retain, nonatomic) UIImage* icon;

- (void) setCallback:(id) target action:(SEL) action;



@end
