//
//  GtActionAwareTableCell.h
//  MyZen
//
//  Created by Mike Fullerton on 12/7/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GtActionContext.h"

@interface GtActionAwareTableCell : UITableViewCell {
	GtActionContext* m_context;
}

@property (readwrite, assign, nonatomic) GtActionContext* actionContext;

@end
