//
//  FLOperationContext.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLOperationQueue.h"

@interface FLOperationContext : FLOperationQueue
+ (id) operationContext;

@property (readonly, assign) BOOL isBusy;
@end

@interface FLOperationContextManager : NSObject {
@private
	NSMutableArray* _contexts;
}

@property (readonly, assign) BOOL isBusy;

+ (id) operationContextManager;

- (void) activateContext:(FLOperationContext*) context;
- (void) deactivateContext:(FLOperationContext*) context;

- (void) cancelAllOperations;
@end



@protocol FLOperationContextObserver <NSObject>
@optional
- (void) operationContextManager:(FLOperationContextManager*) manager contextWasActivated:(FLOperationContext*) context;
- (void) operationContextManager:(FLOperationContextManager*) manager contextWasDeactivated:(FLOperationContext*) context;

@end

//
//@interface FLExclusiveOperationContext : NSObject<FLOperationContext> {
//@private
//	NSMutableArray* _contexts;
//}
//
//- (void) addContext:(FLOperationContext*) context;
//- (void) removeContext:(FLOperationContext*) context;
//@end
