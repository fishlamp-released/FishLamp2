//
//  FLTableViewBatchSelectorView.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/13/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@interface FLTableViewBatchSelectorView : UIView {
@private
	__unsafe_unretained UITableView* _tableView;
}
@property (readwrite, assign, nonatomic) UITableView* tableView;

@end
