//
//  FLActionContextWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/18/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLOperationContext.h"
#import "FLAction.h"
#import "FLWidget.h"

@interface FLActionWidget : FLWidget {
@private
	FLOperationContext* _operationContext;
	FLWeakReference* _action;
}

@property (readwrite, retain, nonatomic) FLOperationContext* actionContext;
@property (readwrite, assign, nonatomic) FLAction* action; 

@end
