//
//  FLModelObject.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/21/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDatabaseTable.h"
#import "FLObjectDescriber.h"

@protocol FLModelObject <FLDatabaseStorable, NSCopying, NSCoding>
 - (id) identifier;
@end

@interface FLModelObject : NSObject<FLModelObject> {
@private
    id _identifier;
}
@property (readwrite, strong) id identifier;
@end

@interface NSObject (FLModelObject)
+ (BOOL) isModelObject;
- (BOOL) isModelObject;
@end

typedef enum {
	FLMergeModePreserveDestination,		//! always keep dest value, even if src has value.
	FLMergeModeSourceWins,				//! if src has value, overwrite dest value.
} FLMergeMode;


// this only works for objects with valid describers.
extern id FLModelObjectCopy(id object);
extern void FLModelObjectEncode(id object, NSCoder* aCoder);
extern void FLModelObjectDecode(id object, NSCoder* aCoder);

extern void FLMergeObjects(id dest, id src, FLMergeMode mergeMode);
extern void FLMergeObjectArrays(NSMutableArray* dest, NSArray* src, FLMergeMode mergeMode, NSArray* arrayItemTypes);

#define FLSynthesizeObjectDescriber() \
            + (BOOL) isModelObject { \
                return YES; \
            } \
            - (BOOL) isModelObject { \
                return YES; \
            }
                        
#define FLSynthesizeCoding() \
            - (id)initWithCoder:(NSCoder *)aCoder { \
                FLModelObjectDecode(self, aCoder); \
                return self; \
            } \
            - (void) encodeWithCoder:(NSCoder*) coder { \
                FLModelObjectEncode(self, coder); \
            }

#define FLSynthesizeCopying() \
            - (id) copyWithZone:(NSZone*) zone { \
                return FLModelObjectCopy(self); \
            }        
            
#define FLSynthesizeModelObjectMethods() \
            FLSynthesizeObjectDescriber() \
            FLSynthesizeCopying() \
            FLSynthesizeCoding()


//            + (FLObjectDescriber*) objectDescriber { \
//                static dispatch_once_t pred = 0; \
//                dispatch_once(&pred, ^{ \
//                    [[self class] registerObjectDescriber]; \
//                }); \
//                return [FLObjectDescriber objectDescriber:[self class]]; \
//            } 
