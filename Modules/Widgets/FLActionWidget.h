//
//  FLActionContextWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/18/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLActionContext.h"
#import "FLAction.h"
#import "FLWidget.h"

@interface FLActionWidget : FLWidget {
@private
	FLActionContext* _actionContext;
	FLActionReference* _action;
}

@property (readwrite, retain, nonatomic) FLActionContext* actionContext;
@property (readwrite, assign, nonatomic) FLAction* action; 

@end
