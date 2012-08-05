//
//	FLActionAwareTableCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/7/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLActionContext.h"

@interface FLActionAwareTableCell : UITableViewCell {
	FLActionContext* _context;
}

@property (readwrite, assign, nonatomic) FLActionContext* actionContext;

@end
