//
//  FLControl.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/18/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@interface FLControl : NSObject

@end



@interface NSObject (FLControl)

@property (readwrite, strong, nonatomic) id controlID;

- (id) controlByID:(id) controlID; // recursive search including self

@end