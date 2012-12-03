//
//	FLActionAwareTableCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/7/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLOperationContext.h"

@interface FLActionAwareTableCell : UITableViewCell {
@private
	__unsafe_unretained FLOperationContext* _context;
}

@property (readwrite, assign, nonatomic) FLOperationContext* actionContext;

@end
