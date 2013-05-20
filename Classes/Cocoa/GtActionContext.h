//
//	GtActionContext.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/8/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampCocoa.h"

#import "GtCancellableOperation.h"

@class GtActionContext;
@class GtAction;

@protocol GtActionContextDelegate;

#define GtActionErrorDomain @"GtActionErrorDomain"
typedef enum {
	GtActionErrorCodeConfigScope = 1,
	GtActionErrorCodeInvalidContext
} GtActionErrorCode;

@protocol GtAction <GtCancellableOperation, NSObject>
- (void) beginActionInContext:(GtActionContext*) context;
- (void) willConfigureAction;
- (void) didConfigureAction;
- (void) finalizeAction;
@property (readwrite, retain, nonatomic) id actionID;
@end

typedef void (^GtConfigureActionBlock)(id action);

@interface GtActionContext : NSObject {
@private
	NSMutableDictionary* m_actions;

	id<GtActionContextDelegate> m_delegate;
	
	struct {
		unsigned int isActive:1;
	} m_flags;
}

- (id) init;
- (id) initAndActivate:(BOOL) activate;

@property (readwrite, assign, nonatomic) id<GtActionContextDelegate> actionContextDelegate; 

@property (readonly, assign, nonatomic) BOOL isActive;
@property (readonly, assign, nonatomic) UIViewController* viewController;
@property (readonly, assign, nonatomic) UIView* contextView;

- (id) beginAction:(id<GtAction>) action 
   configureAction:(GtConfigureActionBlock) configureAction;

- (void) addAction:(id<GtAction>) action;
- (void) removeActionFromContext:(id<GtAction>) action;

- (id<GtAction>) actionByID:(id) actionID;
- (void) cancelActionByID:(id) actionID;

- (BOOL) cancelActions;
- (BOOL) isActive;
- (BOOL) activate;
- (BOOL) deactivate;

- (void) didFinishAllActions;

- (void) willBeginAction:(id<GtAction>) action;
- (void) didFinishAction:(id<GtAction>) action;
@end

@interface GtActionContext (Internal)
- (void) setIsActive:(BOOL) isActive;
@end

@protocol GtActionContextDelegate <NSObject>
- (UIViewController*) actionContextGetViewController:(GtActionContext*) context;

@optional
- (void) actionContextAppEnteredForeground:(GtActionContext*) context;
- (void) actionContextAppEnteredBackground:(GtActionContext*) context;
- (void) actionContextActivated:(GtActionContext*) context;
- (void) actionContextDeactivated:(GtActionContext*) context;
- (void) didCancelActions:(GtActionContext*) context;
@end

