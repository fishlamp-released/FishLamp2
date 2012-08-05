/*
 *  FLObjcRuntime.h
 *  PackMule
 *
 *  Created by Mike Fullerton on 6/29/11.
 *  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
 *
 */
#import "FishLampCore.h"
#import <objc/runtime.h>

// this are in the runtime, but not declared.

const char *getPropertyType(objc_property_t property);

//id objc_getProperty(id self, SEL _cmd, ptrdiff_t offset, BOOL atomic);
//
//void objc_setProperty(id self, SEL _cmd, ptrdiff_t offset, id newValue, BOOL atomic, BOOL shouldCopy);
//
//void objc_copyStruct(void *dest, const void *src, ptrdiff_t size, BOOL atomic, BOOL hasStrong);

/*
 * Copies type name from @encoded string
 * for example NT@"NSMutableArray" results in NSMutableArray
 * if this returns a string, call free on it.
 */
extern char* copyTypeNameFromProperty(objc_property_t property);