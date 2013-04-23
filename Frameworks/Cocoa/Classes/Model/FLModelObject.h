//
//  FLModelObject.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/21/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDatabaseTable.h"
#import "FLObjectDescriber.h"

@protocol FLModelObject <FLDatabaseStorable, FLDescribable, NSCopying, NSCoding>
@property (readonly, strong) id identifier;
@end

@interface FLAbstractModelObject : NSObject<FLModelObject> 
@end

@interface FLModelObject : FLAbstractModelObject {
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
extern void FLMergeObjects(id dest, id src, FLMergeMode mergeMode);
extern void FLMergeObjectArrays(NSMutableArray* dest, NSArray* src, FLMergeMode mergeMode, NSArray* arrayItemTypes);

#define FLSynthesizeObjectDescriber() \
            + (FLObjectDescriber*) objectDescriber { \
                static dispatch_once_t pred = 0; \
                dispatch_once(&pred, ^{ \
                    [FLObjectDescriber registerClass:[self class]]; \
                }); \
                return [FLObjectDescriber objectDescriber:[self class]]; \
            } \
            + (BOOL) isModelObject { \
                return YES; \
            } \
            - (BOOL) isModelObject { \
                return YES; \
            }

            
#define FLSynthesizeSharedDatabaseTable() \
            + (FLDatabaseTable*) sharedDatabaseTable { \
                static FLDatabaseTable* s_table = nil; \
                static dispatch_once_t pred = 0; \
                dispatch_once(&pred, ^{ \
                    s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; \
                }); \
                return s_table; \
            }
            
//#define FLSynthesizeCoding() \
//            - (id)initWithCoder:(NSCoder *)aCoder { \
//                return [self initModelObjectWithCoder:aCoder]; \
//            } \
//            - (void) encodeWithCoder:(NSCoder*) coder { \
//                [self encodeModelObjectWithCoder:coder]; \
//            }
//
//#define FLSynthesizeCopying() \
//        - (id) copyWithZone:(NSZone*) zone { \
//            return [self copyModelObjectWithZone:zone]; \
//        }        
            
#define FLSynthesizeModelObjectMethods() \
            FLSynthesizeObjectDescriber() \
            FLSynthesizeSharedDatabaseTable()

