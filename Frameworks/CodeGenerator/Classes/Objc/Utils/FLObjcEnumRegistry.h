//
//  FLObjcEnumRegistry.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 6/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcNamedObjectCollection.h"
@class FLObjcEnum;

@interface FLObjcEnumRegistry : FLObjcNamedObjectCollection

+ (id) objcEnumRegistry;

- (BOOL) hasEnum:(FLObjcEnum*) theEnum;
- (void) addEnum:(FLObjcEnum*) theEnum;
- (void) replaceEnum:(FLObjcEnum*) theEnum;
- (id) enumForKey:(NSString*) key;
- (id) enumForName:(FLObjcName*) name;

@end
