//
//  NSObject+JsonParser.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/17/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

@interface NSObject (FLJsonParser)

- (BOOL) openJsonObjectForKey:(NSString *)key 
	parentKey:(NSString*) parentKey
	parentObject:(id) parentObject 
	outObject:(id*) outObject;
	
- (BOOL) setJsonData:(id) data forKey:(NSString*) key;

@end
