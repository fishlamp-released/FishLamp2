//
//  FLAsyncAction.h
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

typedef void (^FLActionBlock)(id action);

#import "FLProgressViewControllerProtocol.h"

@class FLActionDescription;
@class FLActionContext;

@protocol FLAsyncAction <NSObject>

@property (readwrite, copy, nonatomic) FLActionBlock onWillStart;

@property (readwrite, copy, nonatomic) FLActionBlock onFinished;

@property (readwrite, retain, nonatomic) FLActionDescription* actionDescription; // also used by error handling

@property (readwrite, retain, nonatomic) id<FLProgressViewController> progressController;

@property (readwrite, retain, nonatomic) id actionID;

@property (readonly, retain, nonatomic) NSError* error;

@property (readonly, retain, nonatomic) FLActionContext* actionContext;

- (void) beginActionInContext:(FLActionContext*) context;

@property (readonly, assign, nonatomic) BOOL wasCancelled;
@end