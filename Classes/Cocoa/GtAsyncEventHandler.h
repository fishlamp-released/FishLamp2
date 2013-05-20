//
//  GtAsyncEventHandler.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/30/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtActionContext.h"

typedef enum {
    GtAsyncEventHandlerResultCreated,
    GtAsyncEventHandlerResultLoadedFromServer,
    GtAsyncEventHandlerResultLoadedFromMemoryCache,
    GtAsyncEventHandlerResultLoadedFromCache
} GtAsyncEventHandlerResult;

typedef void (^GtAsyncEventHandlerResultBlock)(GtAsyncEventHandlerResult result, NSError* error, id data);

@interface GtAsyncEventHandler : NSObject  {
@private
    GtConfigureActionBlock m_configureAction;
    GtActionContext* m_actionContext;
    GtBlock m_didComplete;
    GtAsyncEventHandlerResultBlock m_didLoadData;
    id m_userData;
}

- (id) initWithActionContext:(GtActionContext*) context;

+ (GtAsyncEventHandler*) asyncEventHandler:(GtActionContext*) context;

@property (readonly, retain, nonatomic) GtActionContext* actionContext;
@property (readwrite, retain, nonatomic) id transactionID;

@property (readwrite, copy, nonatomic) GtConfigureActionBlock configureActionBlock;
@property (readwrite, copy, nonatomic) GtAsyncEventHandlerResultBlock didLoadDataBlock;
@property (readwrite, copy, nonatomic) GtErrorCallback didCompleteBlock;

@property (readwrite, retain, nonatomic) id userData; 

- (void) invokeConfigureActionBlock:(id<GtAction>) action;
- (void) invokeDidLoadDataBlock:(GtAsyncEventHandlerResult) result error:(NSError*) error data:(id) data;
- (void) invokeDidCompleteBlock:(NSError*) error;
    
@end
