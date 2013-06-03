//
//	FLContentViewTableViewCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/3/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>


@interface FLSimpleTableViewCell : UITableViewCell {
@private
	UIView* _subview;
}

@property (readwrite, retain, nonatomic) UIView* subview;

@end
