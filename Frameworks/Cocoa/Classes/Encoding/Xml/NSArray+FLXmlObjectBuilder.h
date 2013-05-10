//
//  NSArray+FLXmlObjectBuilder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/7/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLamp.h"
@class FLPropertyDescriber;
@class FLXmlObjectBuilder;

@interface NSArray (FLXmlObjectBuilder)

@end

@interface NSObject (FLXmlObjectBuilderArrays)
- (id) xmlObjectBuilder:(FLXmlObjectBuilder*) builder 
arrayWithElementContents:(FLPropertyDescriber*) propertyDescriber;
@end
