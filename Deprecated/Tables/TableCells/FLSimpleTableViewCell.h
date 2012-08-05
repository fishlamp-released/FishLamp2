//
//	FLContentViewTableViewCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/3/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FLSimpleTableViewCell : UITableViewCell {
@private
	UIView* _subview;
}

@property (readwrite, retain, nonatomic) UIView* subview;

@end
