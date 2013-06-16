//
//  FLCodeLine.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLamp.h"

@interface FLCodeLine : NSObject {
@private
    id _codeLine;
}

@property (readwrite, strong, nonatomic) id codeLine;

- (id) initWithCodeLine:(id) codeLine;

@end
