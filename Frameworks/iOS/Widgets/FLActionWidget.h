//
//  FLActionContextWidget.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/18/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
