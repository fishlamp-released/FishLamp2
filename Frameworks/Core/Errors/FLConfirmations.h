//  FLConfirmations.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
// this is meant to be included by FLAssertions.h
#import "FLAssertionFailedError.h"

#define FLThrowConfirmationFailure(__CODE__, __REASON__, __COMMENT__) \
            FLThrowError([FLAssertionFailedError assertionFailedError:__CODE__ reason:__REASON__ comment:__COMMENT__]) 

/// @brief: Assert that any condition is true
#define FLConfirm(__CONDITION__) \
    if((__CONDITION__) == NO) \
        FLThrowConfirmationFailure(FLAssertionFailureCondition, FLStringWithFormatOrNil(@"%s", #__CONDITION__), nil)

/// @brief: Assert that any condition is true
#define FLConfirmWithComment(__CONDITION__, __COMMENT__, ...) \
    if((__CONDITION__) == NO) \
        FLThrowConfirmationFailure(FLAssertionFailureCondition, FLStringWithFormatOrNil(@"%s", #__CONDITION__), FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__))


NS_INLINE BOOL __FLConfirmationDidFail() { return NO; }



/// @brief: This will throw an diction failure exception
#define FLConfirmationFailure() \
            FLConfirm(__FLConfirmationDidFail())       

/// @brief: This will throw an diction failure exception
#define FLConfirmationFailureWithComment(__COMMENT__, ...) \
            FLConfirmWithComment(__FLConfirmationDidFail(), __COMMENT__, ##__VA_ARGS__)
                                         

/// @brief: Assert a pointer is nil
#define FLConfirmIsNil(__CONDITION__) \
    if((__CONDITION__) != nil) \
        FLThrowConfirmationFailure( FLAssertionFailureIsNotNil, \
                                            FLStringWithFormatOrNil(@"Pointer unexpectedly not nil: %s", #__CONDITION__), \
                                            nil) 

/// @brief: Assert a pointer is nil
#define FLConfirmIsNilWithComment(__CONDITION__, __COMMENT__, ...) \
    if((__CONDITION__) != nil) \
        FLThrowConfirmationFailure( FLAssertionFailureIsNotNil, \
                                            FLStringWithFormatOrNil(@"Pointer unexpectedly not nil: %s", #__CONDITION__), \
                                            FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 

/// @brief: Assert a pointer is NOT nil
#define FLConfirmIsNotNil(__CONDITION__) \
    if((__CONDITION__) == nil) \
        FLThrowConfirmationFailure( FLAssertionFailureIsNil, \
                                            FLStringWithFormatOrNil(@"\"%s == nil\"", #__CONDITION__), \
                                            nil) 


/// @brief: Assert a pointer is NOT nil
#define FLConfirmIsNotNilWithComment(__CONDITION__, __COMMENT__, ...) \
    if((__CONDITION__) == nil) \
        FLThrowConfirmationFailure( FLAssertionFailureIsNil, \
                                            FLStringWithFormatOrNil(@"\"%s == nil\"", #__CONDITION__), \
                                            FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 

/// @brief: Assert a string is empty (either nil or of length 0)
/// empty is either nil or of zero length
#define FLConfirmStringIsNotEmpty(__STRING__) \
    if(FLStringIsEmpty(__STRING__)) \
        FLThrowConfirmationFailure(FLAssertionFailureIsEmpty, FLStringWithFormatOrNil(@"String unexpectedly empty: %s", #__STRING__), nil) 

/// @brief: Assert a string is empty (either nil or of length 0)
/// empty is either nil or of zero length
#define FLConfirmStringIsNotEmptyWithComment(__STRING__, __COMMENT__, ...) \
    if(FLStringIsEmpty(__STRING__)) \
        FLThrowConfirmationFailure(FLAssertionFailureIsEmpty, FLStringWithFormatOrNil(@"String unexpectedly empty: %s", #__STRING__),  FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 

/// @brief: Assert a string is NOT empty
/// empty is either nil or of zero length
#define FLConfirmStringIsEmpty(__STRING__) \
    if((FLStringIsNotEmpty(__STRING__)) \
        FLThrowConfirmationFailure(FLAssertionFailureIsNotEmpty, FLStringWithFormatOrNil(@"String unexpectedly not empty: %s", #__STRING__), nil) 


/// @brief: Assert a string is NOT empty
/// empty is either nil or of zero length
#define FLConfirmStringIsEmptyWithComment(__STRING__, __COMMENT__, ...) \
    if((FLStringIsNotEmpty(__STRING__)) \
        FLThrowConfirmationFailure(FLAssertionFailureIsNotEmpty, FLStringWithFormatOrNil(@"String unexpectedly not empty: %s", #__STRING__),  FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 

/// @brief: Assert a BOOL is true
/// the is the same as AssertYes
#define FLConfirmIsTrue(__BOOL__) \
    if((__BOOL__) == NO) \
        FLThrowConfirmationFailure(FLAssertionFailureIsFalse, FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__BOOL__), nil) 

/// @brief: Assert a BOOL is true
/// the is the same as AssertYes
#define FLConfirmIsTrueWithComment(__BOOL__, __COMMENT__, ...) \
    if((__BOOL__) == NO) \
        FLThrowConfirmationFailure(FLAssertionFailureIsFalse, FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__BOOL__),  FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 
            
/// @brief: Assert a BOOL is false
/// this is the same as AssertNo
#define FLConfirmIsFalse(__BOOL__) \
    if((__BOOL__) == YES) \
        FLThrowConfirmationFailure(FLAssertionFailureIsTrue, FLStringWithFormatOrNil(@"Condition unexpectedly true: %s", #__BOOL__), nil) 

/// @brief: Assert a BOOL is false
/// this is the same as AssertNo
#define FLConfirmIsFalseWithComment(__BOOL__, __COMMENT__, ...) \
    if((__BOOL__) == YES) \
        FLThrowConfirmationFailure(FLAssertionFailureIsTrue, FLStringWithFormatOrNil(@"Condition unexpectedly true: %s", #__BOOL__),  FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 

/// @brief: Assert a BOOL is YES
/// this is the same as AssertTrue
#define FLConfirmIsYes(__BOOL__) \
    if((__BOOL__) == NO) \
        FLThrowConfirmationFailure(FLAssertionFailureIsFalse, FLStringWithFormatOrNil(@"Condition unexpectedly NO: %s", #__BOOL__), nil) 

/// @brief: Assert a BOOL is YES
/// this is the same as AssertTrue
#define FLConfirmIsYesWithComment(__BOOL__, __COMMENT__, ...) \
    if((__BOOL__) == NO) \
        FLThrowConfirmationFailure(FLAssertionFailureIsFalse, FLStringWithFormatOrNil(@"Condition unexpectedly NO: %s", #__BOOL__),  FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 

/// @brief: Assert a BOOL is NO
/// this is the same as AssertNO
#define FLConfirmIsNo(__BOOL__) \
    if((__BOOL__) == YES) \
        FLThrowConfirmationFailure(FLAssertionFailureIsTrue, FLStringWithFormatOrNil(@"Condition unexpectedly YES: %s", #__BOOL__), nil) 

/// @brief: Assert a BOOL is NO
/// this is the same as AssertNO
#define FLConfirmIsNoWithComment(__BOOL__, __COMMENT__, ...) \
    if((__BOOL__) == YES) \
        FLThrowConfirmationFailure(FLAssertionFailureIsTrue, FLStringWithFormatOrNil(@"Condition unexpectedly YES: %s", #__BOOL__),  FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 

/// @brief: Assert values are equal
/// a value is anything that can be compared with ==
#define FLConfirmAreEqual(__LHS__, __RHS__) \
    if((__LHS__) != (__RHS__)) \
        FLThrowConfirmationFailure(FLAssertionFailureAreNotEqual, FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__), nil) 

/// @brief: Assert values are equal
/// a value is anything that can be compared with ==
#define FLConfirmAreEqualWithComment(__LHS__, __RHS__, __COMMENT__, ...) \
    if((__LHS__) != (__RHS__)) \
        FLThrowConfirmationFailure(FLAssertionFailureAreNotEqual, FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__),  FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 

/// @brief: Assert values are NOT equal
/// a value is anything that can be compared with !=
#define FLConfirmAreNotEqual(__LHS__, __RHS__) \
    if((__LHS__) == (__RHS__)) \
        FLThrowConfirmationFailure(FLAssertionFailureAreEqual, FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__), nil) 

/// @brief: Assert values are NOT equal
/// a value is anything that can be compared with !=
#define FLConfirmAreNotEqualWithComment(__LHS__, __RHS__, __COMMENT__, ...) \
    if((__LHS__) == (__RHS__)) \
        FLThrowConfirmationFailure(FLAssertionFailureAreEqual, FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__),  FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 

/// @brief: Assert objects are equal
/// this uses [NSObject isEqual] for the comparison
#define FLConfirmObjectsAreEqual(__LHS__, __RHS__) \
    if([(__LHS__) isEqual:(__RHS__)] == NO) \
        FLThrowConfirmationFailure(FLAssertionFailureAreNotEqual, FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__), nil) 


/// @brief: Assert objects are equal
/// this uses [NSObject isEqual] for the comparison
#define FLConfirmObjectsAreEqualWithComment(__LHS__, __RHS__, __COMMENT__, ...) \
    if([(__LHS__) isEqual:(__RHS__)] == NO) \
        FLThrowConfirmationFailure(FLAssertionFailureAreNotEqual, FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__),  FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 

/// @brief: Assert objects are not equal
/// this uses [NSObject isEqual] for the comparison
#define FLConfirmObjectsAreNotEqual(__LHS__, __RHS__) \
    if([(__LHS__) isEqual:(__RHS__)] == YES) \
        FLThrowConfirmationFailure(FLAssertionFailureAreEqual, FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__), nil) 

/// @brief: Assert objects are not equal
/// this uses [NSObject isEqual] for the comparison
#define FLConfirmObjectsAreNotEqualWithComment(__LHS__, __RHS__, __COMMENT__, ...) \
    if([(__LHS__) isEqual:(__RHS__)] == YES) \
        FLThrowConfirmationFailure(FLAssertionFailureAreEqual, FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__),  FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 

/// @brief: Assert an object is kind of class
#define FLConfirmIsKindOfClass(__LHS__, __RHS__) \
    if([__LHS__ isKindOfClass:NSClassFromString(@#__RHS__)] == NO) \
        FLThrowConfirmationFailure(FLAssertionFailureAreEqual, FLStringWithFormatOrNil(@"%sis unexpectedly not kind of class %s", #__LHS__, #__RHS__), nil) 

/// @brief: Assert an object is kind of class
#define FLConfirmIsKindOfClassWithComment(__LHS__, __RHS__, __COMMENT__, ...) \
    if([__LHS__ isKindOfClass:NSClassFromString(@#__RHS__)] == NO) \
        FLThrowConfirmationFailure(FLAssertionFailureAreEqual, FLStringWithFormatOrNil(@"%sis unexpectedly not kind of class %s", #__LHS__, #__RHS__),  FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 

/// @brief: Assert code is implemented
#define FLConfirmIsImplemented() \
        FLThrowConfirmationFailure(FLAssertionFailureNotImplemented, nil, nil) 

/// @brief: Assert code is implemented
#define FLConfirmIsImplementedWithComment(__COMMENT__, ...) \
        FLThrowConfirmationFailure(FLAssertionFailureNotImplemented, nil,  FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 

/// @brief: Assert if the code isn't fixed
#define FLConfirmIsFixed() \
        FLThrowConfirmationFailure(FLAssertionFailureFixMe, nil, nil) 

/// @brief: Assert if the code isn't fixed
#define FLConfirmIsFixedWithComment(__COMMENT__, ...) \
        FLThrowConfirmationFailure(FLAssertionFailureFixMe, nil,  FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 

/// @brief: Assertion fails because there's known bug here
#define FLConfirmIsBug() \
        FLThrowConfirmationFailure(FLAssertionFailureBug, nil, nil) 

/// @brief: Assertion fails because there's known bug here
#define FLConfirmIsBugWithComment(__COMMENT__, ...) \
        FLThrowConfirmationFailure(FLAssertionFailureBug, nil,  FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 

/// @brief: clients of this code must override this
#define FLConfirmIsOverridden() \
        FLThrowConfirmationFailure(FLAssertionFailureRequiredOverride, nil, nil) 

/// @brief: clients of this code must override this
#define FLConfirmIsOverriddenWithComment(__COMMENT__, ...) \
        FLThrowConfirmationFailure(FLAssertionFailureRequiredOverride, nil,  FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__)) 

#define FLConfirmNotNil         FLConfirmIsNotNil
#define FLConfirmNotNilWithComment        FLConfirmIsNotNilWithComment
#define FLConfirmNil            FLConfirmIsNil
#define FLConfirmNilWithComment           FLConfirmIsNilWithComment
