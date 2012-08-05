//
//	FLActionContext.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/8/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"
#import "FLActionDescription.h"
#import "FLProgressViewControllerProtocol.h"
#import "FLAsyncAction.h"
#import "FLCocoaCompatibility.h"

@protocol FLActionContextDelegate;

#define FLActionErrorDomain @"FLActionErrorDomain"
typedef enum {
	FLActionErrorCodeConfigScope = 1,
	FLActionErrorCodeInvalidContext
} FLActionErrorCode;

@interface FLActionContext : NSObject {
@private
	NSMutableDictionary* _actions;

	__unsafe_unretained id<FLActionContextDelegate> _delegate;
	
	struct {
		unsigned int isActive:1;
	} _flags;
}

- (id) init;
- (id) initAndActivate:(BOOL) activate;

@property (readwrite, assign, nonatomic) id<FLActionContextDelegate> actionContextDelegate; 

@property (readonly, assign, nonatomic) BOOL isActive;
@property (readonly, assign, nonatomic) CocoaViewController* viewController;
@property (readonly, assign, nonatomic) CocoaView* contextView;

- (void) beginAction:(id<FLAsyncAction>) action;

- (void) removeActionFromContext:(id<FLAsyncAction>) action;

- (id<FLAsyncAction>) actionByID:(id) actionID;
- (void) cancelActionByID:(id) actionID;

- (BOOL) cancelActions;
- (BOOL) isActive;
- (BOOL) activate;
- (BOOL) deactivate;

- (void) didFinishAllActions;

- (void) willBeginAction:(id<FLAsyncAction>) action;
- (void) didFinishAction:(id<FLAsyncAction>) action;
@end

@interface FLActionContext (Internal)
- (void) addAction:(id<FLAsyncAction>) action;
- (void) setIsActive:(BOOL) isActive;
@end

@protocol FLActionContextDelegate <NSObject>
- (CocoaViewController*) actionContextGetViewController:(FLActionContext*) context;


//- (void) actionContextRegisterForEvents:(FLActionContext*) context;
//- (void) actionContextUnregisterForEvents:(FLActionContext*) context;

@optional
- (void) actionContextAppEnteredForeground:(FLActionContext*) context;
- (void) actionContextAppEnteredBackground:(FLActionContext*) context;
- (void) actionContextActivated:(FLActionContext*) context;
- (void) actionContextDeactivated:(FLActionContext*) context;
- (void) didCancelActions:(FLActionContext*) context;
@end

