//
//	GtActionAwareTableCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/7/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtActionContext.h"

@interface GtActionAwareTableCell : UITableViewCell {
	GtActionContext* m_context;
}

@property (readwrite, assign, nonatomic) GtActionContext* actionContext;

@end
