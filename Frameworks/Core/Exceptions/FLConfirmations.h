//  FLConfirmations.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
// this is meant to be included by FLAssertions.h

extern void FLThrowConfirmationFailedException(FLAssertionFailure failure, NSString* description, NSString* comment, FLStackTrace* stackTrace);

/// @brief: Assert that any condition is true
#define FLConfirm_(__CONDITION__) \
    if((__CONDITION__) == NO) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureCondition \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__CONDITION__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert that any condition is true
#define FLConfirm_v(__CONDITION__, __COMMENT__, ...) \
    if((__CONDITION__) == NO) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureCondition \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__CONDITION__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]]; 

extern BOOL __FLConfirmationDidFail();

/// @brief: This will throw an diction failure exception
#define FLConfirmationFailure_() \
            FLConfirm_(__FLConfirmationDidFail())

//        if(YES) \
//            @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
//            code:FLAssertionFailureCondition \
//            userInfo:nil \
//            reason:nil \
//            comment:nil \
//            stackTrace:FLCreateStackTrace(YES)]] 
        

/// @brief: This will throw an diction failure exception
#define FLConfirmationFailure_v(__COMMENT__, ...) \
            FLConfirm_v(__FLConfirmationDidFail(), __COMMENT__, ##__VA_ARGS__)

//        if(YES) \
//        @throw [NSException exceptionWithError: \
//                    [NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
//                                               code:FLAssertionFailureCondition \
//                                           userInfo:nil \
//                                             reason:nil \
//                                            comment:FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
//                                         stackTrace:FLCreateStackTrace(YES)]] 
                                         

/// @brief: Assert a pointer is nil
#define FLConfirmIsNil_(__CONDITION__) \
    if((__CONDITION__) != nil) \
        FLThrowConfirmationFailedException( FLAssertionFailureIsNotNil, \
                                            FLStringWithFormatOrNil(@"Pointer unexpectedly not nil: %s", #__CONDITION__), \
                                            nil, \
                                            FLCreateStackTrace(YES)) 

/// @brief: Assert a pointer is nil
#define FLConfirmIsNil_v(__CONDITION__, __COMMENT__, ...) \
    if((__CONDITION__) != nil) \
        FLThrowConfirmationFailedException( FLAssertionFailureIsNotNil, \
                                            FLStringWithFormatOrNil(@"Pointer unexpectedly not nil: %s", #__CONDITION__), \
                                            FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__), \
                                            FLCreateStackTrace(YES)) 

/// @brief: Assert a pointer is NOT nil
#define FLConfirmIsNotNil_(__CONDITION__) \
    if((__CONDITION__) == nil) \
        FLThrowConfirmationFailedException( FLAssertionFailureIsNil, \
                                            FLStringWithFormatOrNil(@"\"%s == nil\"", #__CONDITION__), \
                                            nil, \
                                            FLCreateStackTrace(YES)) 


/// @brief: Assert a pointer is NOT nil
#define FLConfirmIsNotNil_v(__CONDITION__, __COMMENT__, ...) \
    if((__CONDITION__) == nil) \
        FLThrowConfirmationFailedException( FLAssertionFailureIsNil, \
                                            FLStringWithFormatOrNil(@"\"%s == nil\"", #__CONDITION__), \
                                            FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__), \
                                            FLCreateStackTrace(YES)) 

/// @brief: Assert a string is empty (either nil or of length 0)
/// empty is either nil or of zero length
#define FLConfirmStringIsNotEmpty_(__STRING__) \
    if(FLStringIsEmpty(__STRING__)) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureIsEmpty \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"String unexpectedly empty: %s", #__STRING__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert a string is empty (either nil or of length 0)
/// empty is either nil or of zero length
#define FLConfirmStringIsNotEmpty_v(__STRING__, __COMMENT__, ...) \
    if(FLStringIsEmpty(__STRING__)) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureIsEmpty \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"String unexpectedly empty: %s", #__STRING__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert a string is NOT empty
/// empty is either nil or of zero length
#define FLConfirmStringIsEmpty_(__STRING__) \
    if((FLStringIsNotEmpty(__STRING__)) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureIsNotEmpty \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"String unexpectedly not empty: %s", #__STRING__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]]; 


/// @brief: Assert a string is NOT empty
/// empty is either nil or of zero length
#define FLConfirmStringIsEmpty_v(__STRING__, __COMMENT__, ...) \
    if((FLStringIsNotEmpty(__STRING__)) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureIsNotEmpty \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"String unexpectedly not empty: %s", #__STRING__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert a BOOL is true
/// the is the same as AssertYes
#define FLConfirmIsTrue_(__BOOL__) \
    if((__BOOL__) == NO) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureIsFalse \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__BOOL__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert a BOOL is true
/// the is the same as AssertYes
#define FLConfirmIsTrue_v(__BOOL__, __COMMENT__, ...) \
    if((__BOOL__) == NO) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureIsFalse \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__BOOL__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]]; 
            
/// @brief: Assert a BOOL is false
/// this is the same as AssertNo
#define FLConfirmIsFalse_(__BOOL__) \
    if((__BOOL__) == YES) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureIsTrue \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly true: %s", #__BOOL__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert a BOOL is false
/// this is the same as AssertNo
#define FLConfirmIsFalse_v(__BOOL__, __COMMENT__, ...) \
    if((__BOOL__) == YES) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureIsTrue \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly true: %s", #__BOOL__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert a BOOL is YES
/// this is the same as AssertTrue
#define FLConfirmIsYes_(__BOOL__) \
    if((__BOOL__) == NO) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureIsFalse \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly NO: %s", #__BOOL__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert a BOOL is YES
/// this is the same as AssertTrue
#define FLConfirmIsYes_v(__BOOL__, __COMMENT__, ...) \
    if((__BOOL__) == NO) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureIsFalse \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly NO: %s", #__BOOL__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert a BOOL is NO
/// this is the same as AssertNO
#define FLConfirmIsNo_(__BOOL__) \
    if((__BOOL__) == YES) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureIsTrue \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly YES: %s", #__BOOL__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert a BOOL is NO
/// this is the same as AssertNO
#define FLConfirmIsNo_v(__BOOL__, __COMMENT__, ...) \
    if((__BOOL__) == YES) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureIsTrue \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly YES: %s", #__BOOL__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert values are equal
/// a value is anything that can be compared with ==
#define FLConfirmAreEqual_(__LHS__, __RHS__) \
    if((__LHS__) != (__RHS__)) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureAreNotEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert values are equal
/// a value is anything that can be compared with ==
#define FLConfirmAreEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
    if((__LHS__) != (__RHS__)) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureAreNotEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert values are NOT equal
/// a value is anything that can be compared with !=
#define FLConfirmAreNotEqual_(__LHS__, __RHS__) \
    if((__LHS__) == (__RHS__)) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert values are NOT equal
/// a value is anything that can be compared with !=
#define FLConfirmAreNotEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
    if((__LHS__) == (__RHS__)) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert objects are equal
/// this uses [NSObject isEqual] for the comparison
#define FLConfirmObjectsAreEqual_(__LHS__, __RHS__) \
    if([(__LHS__) isEqual:(__RHS__)] == NO) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureAreNotEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]]; 


/// @brief: Assert objects are equal
/// this uses [NSObject isEqual] for the comparison
#define FLConfirmObjectsAreEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
    if([(__LHS__) isEqual:(__RHS__)] == NO) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureAreNotEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert objects are not equal
/// this uses [NSObject isEqual] for the comparison
#define FLConfirmObjectsAreNotEqual_(__LHS__, __RHS__) \
    if([(__LHS__) isEqual:(__RHS__)] == YES) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert objects are not equal
/// this uses [NSObject isEqual] for the comparison
#define FLConfirmObjectsAreNotEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
    if([(__LHS__) isEqual:(__RHS__)] == YES) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert an object is kind of class
#define FLConfirmIsKindOfClass_(__LHS__, __RHS__) \
    if([__LHS__ isKindOfClass:NSClassFromString(@#__RHS__)] == NO) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not kind of class %s", #__LHS__, #__RHS__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert an object is kind of class
#define FLConfirmIsKindOfClass_v(__LHS__, __RHS__, __COMMENT__, ...) \
    if([__LHS__ isKindOfClass:NSClassFromString(@#__RHS__)] == NO) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not kind of class %s", #__LHS__, #__RHS__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert code is implemented
#define FLConfirmIsImplemented_() \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureNotImplemented \
            userInfo:nil \
            reason:nil \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert code is implemented
#define FLConfirmIsImplemented_v(__COMMENT__, ...) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureNotImplemented \
            userInfo:nil \
            reason:nil \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert if the code isn't fixed
#define FLConfirmIsFixed_() \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureFixMe \
            userInfo:nil \
            reason:nil \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assert if the code isn't fixed
#define FLConfirmIsFixed_v(__COMMENT__, ...) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureFixMe \
            userInfo:nil \
            reason:nil \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assertion fails because there's known bug here
#define FLConfirmIsBug_() \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureBug \
            userInfo:nil \
            reason:nil \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: Assertion fails because there's known bug here
#define FLConfirmIsBug_v(__COMMENT__, ...) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureBug \
            userInfo:nil \
            reason:nil \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]]; 

/// @brief: clients of this code must override this
#define FLConfirmIsOverridden_() \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureRequiredOverride \
            userInfo:nil \
            reason:nil \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]]; 


/// @brief: clients of this code must override this
#define FLConfirmIsOverridden_v(__COMMENT__, ...) \
        @throw [NSException exceptionWithError:[NSError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLAssertionFailureRequiredOverride \
            userInfo:nil \
            reason:nil \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]]; 

#define FLConfirmNotNil_         FLConfirmIsNotNil_
#define FLConfirmNotNil_v        FLConfirmIsNotNil_v
#define FLConfirmNil_            FLConfirmIsNil_
#define FLConfirmNil_v           FLConfirmIsNil_v
