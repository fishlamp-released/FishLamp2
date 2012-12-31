//
//  FLDispatchableContext.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLDispatchQueue.h"

typedef void (^FLDispatchableObjectVisitor)(id object, BOOL* stop);

@interface FLDispatchableContext : FLFifoDispatchQueue {
@private
    NSMutableArray* _objects;
}

+ (id) dispatchableContext;

- (void) requestCancel;

- (FLFinisher*) visitObjects:(FLDispatchableObjectVisitor) visitor
                  completion:(FLCompletionBlock) completion;

- (FLFinisher*) visitObjects:(FLDispatchableObjectVisitor) visitor;

@end



//@interface FLServiceManagingContext (FLDispatchableContext) 
//@property (readwrite, strong, nonatomic) FLDispatchableContext* httpService;
//@end

