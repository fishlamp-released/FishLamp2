//
//  FLTableViewBatchSelectorView.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLTableViewBatchSelectorView : UIView {
@private
	UITableView* _tableView;
}
@property (readwrite, assign, nonatomic) UITableView* tableView;

@end
