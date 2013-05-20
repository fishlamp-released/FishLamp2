//
//  GtActionContextWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/18/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtActionContext.h"
#import "GtAction.h"
#import "GtWidget.h"

@interface GtActionWidget : GtWidget {
@private
	GtActionContext* m_actionContext;
	GtActionReference* m_action;
}

@property (readwrite, retain, nonatomic) GtActionContext* actionContext;
@property (readwrite, assign, nonatomic) GtAction* action; 

@end
