//
//  GtActionContext.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/8/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GtWeakReference.h"

//typedef enum
//{
//foo
//	GtUserInputCancel,
//	GtDeactivationCancel,
//	GtAppQuittingCancel
//} GtCancelReason;

@class GtAction;

@interface GtActionContext : NSObject<GtWeaklyReferencedObject> {
@private
	NSMutableArray* m_actions;
	id m_delegate;
	GtDeclareWeakRefMember();

    struct {
        unsigned int isActive:1;
    } m_flags;
	
#if DEBUG
	NSString* m_delegateType;
#endif	
}

- (id) init;
- (id) initAndActivate:(BOOL) activate;

@property (readwrite, assign, nonatomic) id delegate;
@property (readonly, assign, nonatomic) BOOL isActive;

- (void) addAction:(GtAction*) action;
- (void) removeAction:(GtAction*) action;

- (BOOL) terminateActions; // returns true if cancelled anything
- (BOOL) cancelActions;
- (BOOL) isActive;
- (BOOL) activate;
- (BOOL) deactivate;

#if DEBUG
- (void) setDelegateTypeWithClass:(Class) class;
#endif

@end

@interface GtActionContext (Internal)
- (void) setIsActive:(BOOL) isActive;
@end

@protocol GtActionContextDelegate <NSObject>
@optional
- (void) actionContextActivated:(GtActionContext*) context;

- (void) actionContextDeactivated:(GtActionContext*) context;

- (void) actionContextWasCancelled:(GtActionContext*) context 
                  actionsCancelled:(NSArray*) actionsCancelled 
                     wasTerminated:(BOOL) wasTerminated;
@end