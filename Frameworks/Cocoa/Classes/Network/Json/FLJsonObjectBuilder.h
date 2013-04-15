//
//  FLJsonObjectBuilder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDataDecoding.h"
#import "FLTypeDesc.h"

@interface FLJsonObjectBuilder : NSObject {
@private
    id<FLDataDecoding> _decoder;
}
@property (readonly, strong,nonatomic) id<FLDataDecoding> decoder;

- (id) initWithDataDecoder:(id<FLDataDecoding>) decoder;
+ (id) jsonObjectBuilder:(id<FLDataDecoding>) decoder;
+ (id) jsonObjectBuilder;

- (NSArray*) arrayOfObjectsFromJSON:(id) jsonObject withTypeDescs:(NSArray*) arrayOfObjectDescriber;
- (NSArray*) arrayOfObjectsFromJSON:(id) json expectedRootObjectClass:(Class) type;
- (id) objectFromJSON:(id) parsedJson expectedRootObjectClass:(Class) type;

@end