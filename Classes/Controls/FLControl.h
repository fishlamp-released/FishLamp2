//
//  FLControl.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/18/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLControl : NSObject

@end



@interface NSObject (FLControl)

@property (readwrite, strong, nonatomic) id controlID;

- (id) controlByID:(id) controlID; // recursive search including self

@end