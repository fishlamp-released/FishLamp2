//
//	GtCodeGeneratorObjectMore.h
//	PackMule
//
//	Created by Mike Fullerton on 4/18/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GtObjectiveCCodeGenerator;

@interface GtCodeGeneratorObject (More)

- (void) configure:(GtObjectiveCCodeGenerator*) schema;
- (void) generate:(GtObjectiveCCodeGenerator*) generator;


- (GtCodeGeneratorObjectCategory*) categoryByName:(NSString*) name;

- (void) addDependency:(NSString*) item generator:(GtObjectiveCCodeGenerator*) generator;

@end
