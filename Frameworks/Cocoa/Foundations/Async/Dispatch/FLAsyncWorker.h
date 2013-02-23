//
//  FLAsyncWorker.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLFinisher;

@protocol FLAsyncWorker <NSObject>
- (void) startWorkingInContext:(id) context 
                  withObserver:(id) observer 
                      finisher:(FLFinisher*) finisher;
- (void) requestCancel;
@end

