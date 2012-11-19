//
//  FLNetworkStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLObservable.h"

@protocol FLNetworkStream;
typedef void (^FLStreamClosedBlock)(id<FLNetworkStream> stream);

@protocol FLNetworkStream <FLObservable>

@property (readonly, assign) BOOL isOpen;
- (void) openStream:(FLStreamClosedBlock) didCloseBlock;
- (void) closeStream:(NSError*) error;

@property (readonly, strong) NSError* error;
@end

@protocol FLNetworkStreamObserver <NSObject>
- (void) networkStreamWillOpen:(id<FLNetworkStream>) networkStream;
- (void) networkStreamDidOpen:(id<FLNetworkStream>) networkStream;
- (void) networkStreamWillClose:(id<FLNetworkStream>) networkStream;
- (void) networkStreamDidClose:(id<FLNetworkStream>) networkStream;
@end

