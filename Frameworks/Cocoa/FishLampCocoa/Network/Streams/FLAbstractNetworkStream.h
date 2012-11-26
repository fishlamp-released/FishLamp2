//
//  FLAbstactNetworkStream.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLNetworkStream.h"
#import "FLObservable.h"
#import "FLDispatchQueue.h"

@interface FLAbstractNetworkStream : FLObservable<FLNetworkStream> {
@private
    FLFinisher* _closeFinisher;
    FLDispatchQueue* _dispatchQueue;
    id _result;
    BOOL _isOpen;
    BOOL _didClose;
    BOOL _busy;
}
@property (readonly, strong) FLDispatchQueue* dispatchQueue;
@end

@interface FLAbstractNetworkStream (CFStream)
- (void) handleStreamEvent:(CFStreamEventType) eventType;
@end

@protocol FLConcreteNetworkStream <NSObject>
- (void) openStream;
- (void) closeStream;
@end
