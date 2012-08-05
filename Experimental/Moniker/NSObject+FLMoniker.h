//
//  NSObject+FLMoniker.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/18/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FLMoniker)

@property (readwrite, strong, nonatomic) id moniker;

- (BOOL) monikerIsEqualTo:(id) moniker;

- (id) objectByMoniker:(id) aMoniker;
@end

//@interface NSArray (FLMoniker)
//- (id) objectByMoniker:(id) aMoniker;
//@end
//
//@interface NSDictionary (FLMoniker)
//- (id) objectByMoniker:(id) aMoniker;
//@end
//
//@interface NSSet (FLMoniker)
//- (id) objectByMoniker:(id) aMoniker;
//@end

