//
//  FLAssertions_Debug.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

//// FLAssert(BOOL condition, __COMMENT__, ...)
//
//#define confirm_(__CONDITION__) \
//            __FLAssert(FLThrowAssertionFailure, __CONDITION__, nil)
//
//#define cconfirm_(__CONDITION__) \
//            __FLAssert(FLCThrowAssertionFailure, __CONDITION__, nil)
//
//#define assert_(__CONDITION__, __COMMENT__, ...) \
//            __FLAssert(FLThrowAssertionFailure, __CONDITION__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//#define cassert_(__CONDITION__, __COMMENT__, ...) \
//            __FLAssert(FLCThrowAssertionFailure, __CONDITION__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//
//// FLAssertFailed(__COMMENT__, ...)
//
//#define assertion_failed_(__COMMENT__, ...) \
//            __FLAssertFailed(FLThrowAssertionFailure, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//#define cassertion_failed_(__COMMENT__, ...) \
//            __FLCAssertionFailed(FLCThrowAssertionFailure, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//
//// FLAssertNotNil(id pointer, __COMMENT__, ...)
//
//#define confirm_is_not_nil_(__POINTER__) \
//            __FLAssertNotNil(FLThrowAssertionFailure, __POINTER__, nil)
//
//#define cconfirm_is_not_nil_(__POINTER__) \
//            __FLAssertNotNil(FLCThrowAssertionFailure, __POINTER__, nil)
//
//#define assert_is_not_nil_(__POINTER__, __COMMENT__, ...) \
//            __FLAssertNotNil(FLThrowAssertionFailure, __POINTER__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//#define cassert_is_not_nil_(__POINTER__, __COMMENT__, ...) \
//            __FLAssertNotNil(FLCThrowAssertionFailure, __POINTER__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//// FLAssertNil(id point, __COMMENT__, ...)
//
//#define confirm_is_nil_(__POINTER__) \
//            __FLAssertNil(FLThrowAssertionFailure, __POINTER__, nil)
//
//#define cconfirm_is_nil_(__POINTER__) \
//            __FLAssertNil(FLCThrowAssertionFailure, __POINTER__, nil)
//
//#define assert_is_nil_(__POINTER__, __COMMENT__, ...) \
//            __FLAssertNil(FLThrowAssertionFailure, __POINTER__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//#define cassert_is_nil_(__POINTER__, __COMMENT__, ...) \
//            __FLAssertNil(FLCThrowAssertionFailure, __POINTER__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//// FLAssertStringIsNotEmpty(NSString* stringOrNil, __COMMENT__, ...)
//
//#define confirm_string_is_not_empty_(__STRING__) \
//            __FLAssertStringIsNotEmpty(FLThrowAssertionFailure, __STRING__, nil)
//
//#define cconfirm_string_is_not_empty(__STRING__) \
//            __FLAssertStringIsNotEmpty(FLCThrowAssertionFailure, __STRING__, nil)
//
//#define assert_string_is_not_empty(__STRING__, __COMMENT__, ...) \
//            __FLAssertStringIsNotEmpty(FLThrowAssertionFailure, __STRING__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//#define ccassert_string_is_not_empty(__STRING__, __COMMENT__, ...) \
//            __FLAssertStringIsNotEmpty(FLCThrowAssertionFailure, __STRING__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//// FLAssertTrue(BOOL shouldBeTrue, __COMMENT__, ...)
//
//#define confirm_is_true_(__CONDITION__) \
//            __FLAssertTrue(FLThrowAssertionFailure, __CONDITION__, nil)
//
//#define cconfirm_is_true_(__CONDITION__) \
//            __FLAssertTrue(FLCThrowAssertionFailure, __CONDITION__, nil)
//
//#define assert_is_true_(__CONDITION__, __COMMENT__, ...) \
//            __FLAssertTrue(FLThrowAssertionFailure, __CONDITION__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//#define cassert_is_true_(__CONDITION__, __COMMENT__, ...) \
//            __FLAssertTrue(FLCThrowAssertionFailure, __CONDITION__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//// FLAssertFalse(BOOL shouldBeFalse, __COMMENT__, ...)
//
//#define confirm_is_false_(__CONDITION__) \
//            __FLAssertFalse(FLThrowAssertionFailure, __CONDITION__, nil)
//
//#define confirm_is_false_(__CONDITION__) \
//            __FLAssertFalse(FLCThrowAssertionFailure, __CONDITION__, nil)
//
//#define assert_is_false_(__CONDITION__, __COMMENT__, ...) \
//            __FLAssertFalse(FLThrowAssertionFailure, __CONDITION__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//#define cassert_is_false_(__CONDITION__, __COMMENT__, ...) \
//            __FLAssertFalse(FLCThrowAssertionFailure, __CONDITION__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//// FLAssertValuesAreEqual(VALUE lhs, VALUE rhs)
//// VALUE is anything that can be compared with "==". For example FLAssertValuesAreEqual(5,5)
//
//#define confirm_values_are_equal_(__LHS__, __RHS__) \
//            __FLAssertValuesAreEqual(FLThrowAssertionFailure, __LHS__, __RHS__, nil)
//
//#define cconfirm_values_are_equal_(__LHS__, __RHS__) \
//            __FLAssertValuesAreEqual(FLCThrowAssertionFailure, __LHS__, __RHS__, nil)
//
//#define assert_values_are_equal_(__LHS__, __RHS__, __COMMENT__, ...) \
//            __FLAssertValuesAreEqual(FLThrowAssertionFailure, __LHS__, __RHS__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//#define ccassert_values_are_equal_(__LHS__, __RHS__, __COMMENT__, ...) \
//            __FLAssertValuesAreEqual(FLCThrowAssertionFailure, __LHS__, __RHS__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//
//// FLAssertValuesAreNotEqual(VALUE lhs, VALUE rhs)
//// VALUE is anything that can be compared with "!=". For example FLAssertValuesAreNotEqual(5,6)
//
//#define confirm_values_are_not_equal_(__LHS__, __RHS__) FLConfirmValuesAreNotEqual(__LHS__, __RHS__)
//
//#define cconfirm_values_are_not_equal_(__LHS__, __RHS__) FLCConfirmValuesAreNotEqual(__LHS__, __RHS__) 
//
//#define assert_values_are_not_equal_(__LHS__, __RHS__, __COMMENT__, ...) FLAssertValuesAreNotEqual(__LHS__, __RHS__, __COMMENT__, ...) 
//
//#define cassert_values_are_not_equal_(__LHS__, __RHS__, __COMMENT__, ...) FLCAssertValuesAreNotEqual(__LHS__, __RHS__, __COMMENT__, ...)
//
//// FLAssertObjectsAreEqual(id lhs, id rhs)
//// this calls isEqual to compare objects.
//
//#define confirm_objects_are_equal_(__LHS__, __RHS__) FLConfirmObjectsAreEqual(__LHS__, __RHS__)
//
//#define cconfirm_objects_are_equal_(__LHS__, __RHS__) FLCConfirmObjectsAreEqual(__LHS__, __RHS__) 
//
//#define assert_objects_are_equal_(__LHS__, __RHS__, __COMMENT__, ...) FLAssertObjectsAreEqual(__LHS__, __RHS__, __COMMENT__,  ##__VA_ARGS__)
//
//#define cassert_objects_are_equal_(__LHS__, __RHS__, __COMMENT__, ...) FLCAssertObjectsAreEqual(__LHS__, __RHS__, __COMMENT__, ...) )
//
//// FLAssertObjectsAreNotEqual(id lhs, id rhs)
//// this calls isEqual to compare objects.
//
//#define FLConfirmObjectsAreNotEqual(__LHS__, __RHS__) \
//            __FLAssertObjectsAreNotEqual(FLThrowAssertionFailure, __LHS__, __RHS__, nil)
//
//#define FLCConfirmObjectsAreNotEqual(__LHS__, __RHS__) \
//            __FLAssertObjectsAreNotEqual(FLCThrowAssertionFailure, __LHS__, __RHS__, nil)
//
//#define FLAssertObjectsAreNotEqual(__LHS__, __RHS__, __COMMENT__, ...) \
//            __FLAssertObjectsAreNotEqual(FLThrowAssertionFailure, __LHS__, __RHS__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//#define FLCAssertObjectsAreNotEqual(__LHS__, __RHS__, __COMMENT__, ...) \
//            __FLAssertObjectsAreNotEqual(FLCThrowAssertionFailure, __LHS__, __RHS__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//// FLAssertType(id object, unquoted type name)
//// example: FLAssertType([NSString string], NSString)
//
//#define FLConfirmType(__OBJ__, __TYPE_NAME__) \
//            __FLAssertType(FLThrowAssertionFailure, __OBJ__, __TYPE_NAME__, nil)
//
//#define FLCConfirmType(__OBJ__, __TYPE_NAME__) \
//            __FLAssertType(FLCThrowAssertionFailure, __OBJ__, __TYPE_NAME__, nil)
//
//#define FLAssertType(__OBJ__, __TYPE_NAME__, __COMMENT__, ...) \
//            __FLAssertType(FLThrowAssertionFailure, __OBJ__, __TYPE_NAME__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//#define FLCAssertType(__OBJ__, __TYPE_NAME__, __COMMENT__, ...) \
//            __FLAssertType(FLCThrowAssertionFailure, __OBJ__, __TYPE_NAME__, FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//// FLAssertImplemented(__COMMENT__, ...)
//
//#define FLCConfirmImplemented() \
//            __FLNotImplemented(FLThrowAssertionFailure,nil)
//
//#define FLCConfirmImplemented() \
//            __FLNotImplemented(FLCThrowAssertionFailure,nil)
//
//#define FLAssertImplemented(__COMMENT__, ...) \
//            __FLNotImplemented(FLThrowAssertionFailure,FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//#define FLCAssertImplemented(__COMMENT__, ...) \
//            __FLNotImplemented(FLCThrowAssertionFailure,FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//// FLFixMe(__COMMENT__, ...)
//
////#define FLFixMe() \
////            __FLFixMe(FLThrowAssertionFailure,nil)
////
////#define FLCFixMe() \
////            __FLFixMe(FLCThrowAssertionFailure,nil)
//
//#define FLFixMe(__COMMENT__, ...) \
//            __FLFixMe(FLThrowAssertionFailure,FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//#define FLCFixMe(__COMMENT__, ...) \
//            __FLFixMe(FLCThrowAssertionFailure,FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//
//// FLBug(..)
//
////#define FLBug() \
////        __FLBug(FLThrowAssertionFailure,nil)
////
////#define FLCBug() \
////        __FLBug(FLCThrowAssertionFailure,nil)
//
//#define FLBug(__COMMENT__, ...) \
//        __FLBug(FLThrowAssertionFailure,FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//#define FLCBug(__COMMENT__, ...) \
//        __FLBug(FLCThrowAssertionFailure,FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))
//
//// FLAssertDefaultInitNotCalled(__COMMENT__, ...)
//
//#define FLConfirmDefaultInitNotCalled() \
//            - (id) init { \
//                FLThrowAssertionFailure(    FLFailureTypeUnsupportedInit, \
//                                            nil, \
//                                            nil); \
//                return self; \
//            }
//
//#define FLAssertDefaultInitNotCalled(__COMMENT__, ...) \
//            - (id) init { \
//                FLThrowAssertionFailure(    FLFailureTypeUnsupportedInit, \
//                                            nil, \
//                                            FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)); \
//                return self; \
//            }
//
//
//// FLIsRequiredOverride(__COMMENT__, ...)
//
//#define FLConfirmRequiredOverride() \
//            FLThrowAssertionFailure(FLFailureTypeRequiredOverride, nil , nil);
//
//#define FLIsRequiredOverride(__COMMENT__, ...) \
//            FLThrowAssertionFailure(FLFailureTypeRequiredOverride, nil , FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__));
//
//
//
//#else
//
//#define FLThrowAssertionFailure(__TYPE__, __REASON_OR_NIL__, __COMMENT_OR_NIL__)
//
//#define FLAssert(__CONDITION__, __COMMENT__, ...) 
//
//#define FLAssertFailed(__COMMENT__, ...) 
//        
//#define FLAssertNotNil(__POINTER__, __COMMENT__, ...) 
//
//#define FLAssertNil(__POINTER__, __COMMENT__, ...) 
//
//#define FLAssertStringIsNotEmpty(__STRING__, __COMMENT__, ...) 
//
//#define FLAssertTrue(__CONDITION__, __COMMENT__, ...) 
//
//#define FLAssertValuesAreEqual(__LHS__, __RHS__, __COMMENT__, ...) 
//
//#define FLAssertValuesAreNotEqual(__LHS__, __RHS__, __COMMENT__, ...) 
//
//#define FLAssertObjectsAreEqual(__LHS__, __RHS__, __COMMENT__, ...) 
//
//#define FLAssertObjectsAreNotEqual(__LHS__, __RHS__, __COMMENT__, ...) 
//    
//#define FLAssertFalse(__CONDITION__, __COMMENT__, ...) 
//
//#define FLAssertType(__OBJ__, __TYPE_NAME__, __COMMENT__, ...)
//
//#define FLAssertDefaultInitNotCalled(__COMMENT__, ...)
//		      
//#define FLIsRequiredOverride(__COMMENT__, ...) \
//
//#define FLAssertImplemented(__COMMENT__, ...) \
//
//#define FLFixMe(__COMMENT__, ...)
//
//#define FLBug(__COMMENT__, ...)
//
//#endif

