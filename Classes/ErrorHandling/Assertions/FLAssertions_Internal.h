//
//  FLAssertionsForObjects.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

 
#define __FLAssert(__THROW__, __CONDITION__, __COMMENT__) \
            if(!(__CONDITION__)) \
                __THROW__(FLFailureTypeCondition, @#__CONDITION__, __COMMENT__)

#define __FLAssertFailed(__THROW__, __COMMENT__) \
            __THROW__(FLFailureTypeCondition, nil, __COMMENT__)
        
#define __FLAssertNotNil(__THROW__, __POINTER__, __COMMENT__) \
            if((__POINTER__) == nil) \
                __THROW__(    FLFailureTypeIsNil, \
                                            (FLAssertionComment(@"%s == nil", #__POINTER__)), \
                                            __COMMENT__)

#define __FLAssertNil(__THROW__, __POINTER__, __COMMENT__) \
            if((__POINTER__) != nil) \
                __THROW__(    FLFailureTypeIsNotNil, \
                                            (FLAssertionComment(@"%s != nil", #__POINTER__)),\
                                            __COMMENT__)

#define __FLAssertStringIsNotEmpty(__THROW__, __STRING__, __COMMENT__) \
            if(FLStringIsEmpty(__STRING__)) \
                __THROW__(    FLFailureTypeIsEmpty, \
                                            (FLAssertionComment(@"%s.length == 0", #__STRING__)), \
                                            __COMMENT__)

#define __FLAssertTrue(__THROW__, __CONDITION__, __COMMENT__) \
            if((__CONDITION__) != YES) \
                 __THROW__(   FLFailureTypeIsFalse, \
                                            (FLAssertionComment(@"%s != YES", #__CONDITION__)), \
                                            __COMMENT__)

#define __FLAssertValuesAreEqual(__THROW__, __LHS__, __RHS__, __COMMENT__) \
            if((__LHS__) != (__RHS__)) \
                 __THROW__(   FLFailureTypeAreNotEqual, \
                                            (FLAssertionComment(@"%s != %s", #__LHS__, #__RHS__)), \
                                            __COMMENT__)

#define __FLAssertValuesAreNotEqual(__THROW__, __LHS__, __RHS__, __COMMENT__) \
            if((__LHS__) == (__RHS__)) \
                 __THROW__(   FLFailureTypeAreEqual, \
                                            (FLAssertionComment(@"%s == %s", #__LHS__, #__RHS__)), \
                                            __COMMENT__)

#define __FLAssertObjectsAreEqual(__THROW__, __LHS__, __RHS__, __COMMENT__) \
            if(![__LHS__ isEqual:__RHS__]) \
                 __THROW__(   FLFailureTypeAreNotEqual, \
                                            (FLAssertionComment(@"%s != %s", #__LHS__, #__RHS__)), \
                                            __COMMENT__)

#define __FLAssertObjectsAreNotEqual(__THROW__, __LHS__, __RHS__, __COMMENT__) \
            if([__LHS__ isEqual:__RHS__]) \
                 __THROW__(   FLFailureTypeAreNotEqual, \
                                            (FLAssertionComment(@"%s == %s", #__LHS__, #__RHS__)), \
                                            __COMMENT__)
    
#define __FLAssertFalse(__THROW__, __CONDITION__, __COMMENT__) \
            if((__CONDITION__) != NO) \
                 __THROW__(   FLFailureTypeIsTrue, \
                                            (FLAssertionComment(@"%s != NO", #__CONDITION__)),\
                                            __COMMENT__)

#define __FLAssertType(__THROW__, __OBJ__, __TYPE_NAME__, __COMMENT__) \
            do {    id __obj = __OBJ__; \
                    if(!__obj) { \
                        __THROW__(    FLFailureTypeIsNil, \
                                                    (FLAssertionComment(@"%s == nil", #__OBJ__, #__TYPE_NAME__)), \
                                                    __COMMENT__); \
                    } \
                    if(![__obj isKindOfClass:NSClassFromString(@#__TYPE_NAME__)]) { \
                        __THROW__(    FLFailureTypeIsWrongType, \
                                                    (FLAssertionComment(@"[%s class] != %s (it's a %@)", #__OBJ__, #__TYPE_NAME__, NSStringFromClass([__obj class]))), \
                                                    __COMMENT__); \
                    } \
                } while(0)


#if NOT_IMPLEMENTED_WARNINGS

    #define __FLNotImplemented(__THROW__, __COMMENT__) \
                NOT_IMPLEMENTED(__COMMENT__ (This will fail at runtime)); \
                __THROW__(FLFailureTypeNotImplemented, nil, __COMMENT__)

#else

    #define __FLNotImplemented(__THROW__, __COMMENT__) \
                __THROW__(FLFailureTypeNotImplemented, nil, __COMMENT__)

#endif

#if FIXME_WARNINGS

    #define __FLFixMe(__THROW__, __COMMENT__) \
                FIXME(__COMMENT__ (This will fail at runtime)); \
                __THROW__(FLFailureTypeFixMe, nil, __COMMENT__)
#else

    #define __FLFixMe(__THROW__, __COMMENT__) \
                __THROW__(FLFailureTypeFixMe, nil, __COMMENT__)
#endif

#define __FLBug(__THROW__, __COMMENT__) \
            BUG(__COMMENT__ (This will fail at runtime)); \
            __THROW__(FLFailureTypeBug, nil, __COMMENT__)



