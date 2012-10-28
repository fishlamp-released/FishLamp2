// Generated at: 2012-09-14 22:02:46 +0000
/// @brief: Assert that any condition is true
#define FLConfirm_(__CONDITION__) \
    if((__CONDITION__) == NO) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeCondition \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__CONDITION__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert that any condition is true
#define FLCConfirm_(__CONDITION__) \
    if((__CONDITION__) == NO) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeCondition \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__CONDITION__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert that any condition is true
#define FLConfirm_v(__CONDITION__, __COMMENT__, ...) \
    if((__CONDITION__) == NO) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeCondition \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__CONDITION__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert that any condition is true
#define FLCConfirm_v(__CONDITION__, __COMMENT__, ...) \
    if((__CONDITION__) == NO) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeCondition \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__CONDITION__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: This will throw an diction failure exception
#define FLConfirmFailed_() \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeCondition \
            userInfo:nil \
            reason:nil \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: This will throw an diction failure exception
#define FLCConfirmFailed_() \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeCondition \
            userInfo:nil \
            reason:nil \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: This will throw an diction failure exception
#define FLConfirmFailed_v(__COMMENT__, ...) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeCondition \
            userInfo:nil \
            reason:nil \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: This will throw an diction failure exception
#define FLCConfirmFailed_v(__COMMENT__, ...) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeCondition \
            userInfo:nil \
            reason:nil \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a pointer is nil
#define FLConfirmIsNil_(__CONDITION__) \
    if((__CONDITION__) != nil) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsNil \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Pointer unexpectedly not nil: %s", #__CONDITION__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a pointer is nil
#define FLCConfirmIsNil_(__CONDITION__) \
    if((__CONDITION__) != nil) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsNil \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Pointer unexpectedly not nil: %s", #__CONDITION__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a pointer is nil
#define FLConfirmIsNil_v(__CONDITION__, __COMMENT__, ...) \
    if((__CONDITION__) != nil) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsNil \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Pointer unexpectedly not nil: %s", #__CONDITION__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a pointer is nil
#define FLCConfirmIsNil_v(__CONDITION__, __COMMENT__, ...) \
    if((__CONDITION__) != nil) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsNil \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Pointer unexpectedly not nil: %s", #__CONDITION__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a pointer is NOT nil
#define FLConfirmIsNotNil_(__CONDITION__) \
    if((__CONDITION__) == nil) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsNotNil \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Pointer unexpectedly nil: %s", #__CONDITION__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a pointer is NOT nil
#define FLCConfirmIsNotNil_(__CONDITION__) \
    if((__CONDITION__) == nil) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsNotNil \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Pointer unexpectedly nil: %s", #__CONDITION__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a pointer is NOT nil
#define FLConfirmIsNotNil_v(__CONDITION__, __COMMENT__, ...) \
    if((__CONDITION__) == nil) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsNotNil \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Pointer unexpectedly not nil: %s", #__CONDITION__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a pointer is NOT nil
#define FLCConfirmIsNotNil_v(__CONDITION__, __COMMENT__, ...) \
    if((__CONDITION__) == nil) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsNotNil \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Pointer unexpectedly not nil: %s", #__CONDITION__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a string is empty (either nil or of length 0)
/// empty is either nil or of zero length
#define FLConfirmStringIsNotEmpty_(__STRING__) \
    if(FLStringIsEmpty(__STRING__)) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsEmpty \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"String unexpectedly empty: %s", #__STRING__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a string is empty (either nil or of length 0)
/// empty is either nil or of zero length
#define FLCConfirmStringIsNotEmpty_(__STRING__) \
    if(FLStringIsEmpty(__STRING__)) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsEmpty \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"String unexpectedly empty: %s", #__STRING__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a string is empty (either nil or of length 0)
/// empty is either nil or of zero length
#define FLConfirmStringIsNotEmpty_v(__STRING__, __COMMENT__, ...) \
    if(FLStringIsEmpty(__STRING__)) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsEmpty \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"String unexpectedly empty: %s", #__STRING__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a string is empty (either nil or of length 0)
/// empty is either nil or of zero length
#define FLCConfirmStringIsNotEmpty_v(__STRING__, __COMMENT__, ...) \
    if(FLStringIsEmpty(__STRING__)) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsEmpty \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"String unexpectedly empty: %s", #__STRING__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a string is NOT empty
/// empty is either nil or of zero length
#define FLConfirmStringIsEmpty_(__STRING__) \
    if((FLStringIsNotEmpty(__STRING__)) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsNotEmpty \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"String unexpectedly not empty: %s", #__STRING__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a string is NOT empty
/// empty is either nil or of zero length
#define FLCConfirmStringIsEmpty_(__STRING__) \
    if((FLStringIsNotEmpty(__STRING__)) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsNotEmpty \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"String unexpectedly not empty: %s", #__STRING__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a string is NOT empty
/// empty is either nil or of zero length
#define FLConfirmStringIsEmpty_v(__STRING__, __COMMENT__, ...) \
    if((FLStringIsNotEmpty(__STRING__)) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsNotEmpty \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"String unexpectedly not empty: %s", #__STRING__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a string is NOT empty
/// empty is either nil or of zero length
#define FLCConfirmStringIsEmpty_v(__STRING__, __COMMENT__, ...) \
    if((FLStringIsNotEmpty(__STRING__)) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsNotEmpty \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"String unexpectedly not empty: %s", #__STRING__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a BOOL is true
/// the is the same as AssertYes
#define FLConfirmIsTrue_(__BOOL__) \
    if((__BOOL__) == NO) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsFalse \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__BOOL__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a BOOL is true
/// the is the same as AssertYes
#define FLCConfirmIsTrue_(__BOOL__) \
    if((__BOOL__) == NO) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsFalse \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__BOOL__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a BOOL is true
/// the is the same as AssertYes
#define FLConfirmIsTrue_v(__BOOL__, __COMMENT__, ...) \
    if((__BOOL__) == NO) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsFalse \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__BOOL__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a BOOL is true
/// the is the same as AssertYes
#define FLCConfirmIsTrue_v(__BOOL__, __COMMENT__, ...) \
    if((__BOOL__) == NO) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsFalse \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__BOOL__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a BOOL is false
/// this is the same as AssertNo
#define FLConfirmIsFalse_(__BOOL__) \
    if((__BOOL__) == YES) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsTrue \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly true: %s", #__BOOL__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a BOOL is false
/// this is the same as AssertNo
#define FLCConfirmIsFalse_(__BOOL__) \
    if((__BOOL__) == YES) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsTrue \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly true: %s", #__BOOL__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a BOOL is false
/// this is the same as AssertNo
#define FLConfirmIsFalse_v(__BOOL__, __COMMENT__, ...) \
    if((__BOOL__) == YES) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsTrue \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly true: %s", #__BOOL__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a BOOL is false
/// this is the same as AssertNo
#define FLCConfirmIsFalse_v(__BOOL__, __COMMENT__, ...) \
    if((__BOOL__) == YES) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsTrue \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly true: %s", #__BOOL__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a BOOL is YES
/// this is the same as AssertTrue
#define FLConfirmIsYes_(__BOOL__) \
    if((__BOOL__) == NO) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsFalse \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly NO: %s", #__BOOL__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a BOOL is YES
/// this is the same as AssertTrue
#define FLCConfirmIsYes_(__BOOL__) \
    if((__BOOL__) == NO) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsFalse \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly NO: %s", #__BOOL__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a BOOL is YES
/// this is the same as AssertTrue
#define FLConfirmIsYes_v(__BOOL__, __COMMENT__, ...) \
    if((__BOOL__) == NO) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsFalse \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly NO: %s", #__BOOL__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a BOOL is YES
/// this is the same as AssertTrue
#define FLCConfirmIsYes_v(__BOOL__, __COMMENT__, ...) \
    if((__BOOL__) == NO) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsFalse \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly NO: %s", #__BOOL__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a BOOL is NO
/// this is the same as AssertNO
#define FLConfirmIsNo_(__BOOL__) \
    if((__BOOL__) == YES) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsTrue \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly YES: %s", #__BOOL__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a BOOL is NO
/// this is the same as AssertNO
#define FLCConfirmIsNo_(__BOOL__) \
    if((__BOOL__) == YES) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsTrue \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly YES: %s", #__BOOL__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a BOOL is NO
/// this is the same as AssertNO
#define FLConfirmIsNo_v(__BOOL__, __COMMENT__, ...) \
    if((__BOOL__) == YES) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsTrue \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly YES: %s", #__BOOL__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert a BOOL is NO
/// this is the same as AssertNO
#define FLCConfirmIsNo_v(__BOOL__, __COMMENT__, ...) \
    if((__BOOL__) == YES) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeIsTrue \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"Condition unexpectedly YES: %s", #__BOOL__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert values are equal
/// a value is anything that can be compared with ==
#define FLConfirmAreEqual_(__LHS__, __RHS__) \
    if((__LHS__) != (__RHS__)) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreNotEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert values are equal
/// a value is anything that can be compared with ==
#define FLCConfirmAreEqual_(__LHS__, __RHS__) \
    if((__LHS__) != (__RHS__)) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreNotEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert values are equal
/// a value is anything that can be compared with ==
#define FLConfirmAreEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
    if((__LHS__) != (__RHS__)) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreNotEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert values are equal
/// a value is anything that can be compared with ==
#define FLCConfirmAreEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
    if((__LHS__) != (__RHS__)) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreNotEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert values are NOT equal
/// a value is anything that can be compared with !=
#define FLConfirmAreNotEqual_(__LHS__, __RHS__) \
    if((__LHS__) == (__RHS__)) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert values are NOT equal
/// a value is anything that can be compared with !=
#define FLCConfirmAreNotEqual_(__LHS__, __RHS__) \
    if((__LHS__) == (__RHS__)) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert values are NOT equal
/// a value is anything that can be compared with !=
#define FLConfirmAreNotEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
    if((__LHS__) == (__RHS__)) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert values are NOT equal
/// a value is anything that can be compared with !=
#define FLCConfirmAreNotEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
    if((__LHS__) == (__RHS__)) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert objects are equal
/// this uses [NSObject isEqual] for the comparison
#define FLConfirmObjectsAreEqual_(__LHS__, __RHS__) \
    if([(__LHS__) isEqual:(__RHS__)] == NO) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreNotEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert objects are equal
/// this uses [NSObject isEqual] for the comparison
#define FLCConfirmObjectsAreEqual_(__LHS__, __RHS__) \
    if([(__LHS__) isEqual:(__RHS__)] == NO) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreNotEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert objects are equal
/// this uses [NSObject isEqual] for the comparison
#define FLConfirmObjectsAreEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
    if([(__LHS__) isEqual:(__RHS__)] == NO) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreNotEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert objects are equal
/// this uses [NSObject isEqual] for the comparison
#define FLCConfirmObjectsAreEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
    if([(__LHS__) isEqual:(__RHS__)] == NO) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreNotEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert objects are not equal
/// this uses [NSObject isEqual] for the comparison
#define FLConfirmObjectsAreNotEqual_(__LHS__, __RHS__) \
    if([(__LHS__) isEqual:(__RHS__)] == YES) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert objects are not equal
/// this uses [NSObject isEqual] for the comparison
#define FLCConfirmObjectsAreNotEqual_(__LHS__, __RHS__) \
    if([(__LHS__) isEqual:(__RHS__)] == YES) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert objects are not equal
/// this uses [NSObject isEqual] for the comparison
#define FLConfirmObjectsAreNotEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
    if([(__LHS__) isEqual:(__RHS__)] == YES) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert objects are not equal
/// this uses [NSObject isEqual] for the comparison
#define FLCConfirmObjectsAreNotEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
    if([(__LHS__) isEqual:(__RHS__)] == YES) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert an object is kind of class
#define FLConfirmIsKindOfClass_(__LHS__, __RHS__) \
    if([__LHS__ isKindOfClass:NSClassFromString(@#__RHS__)] == NO) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not kind of class %s", #__LHS__, #__RHS__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert an object is kind of class
#define FLCConfirmIsKindOfClass_(__LHS__, __RHS__) \
    if([__LHS__ isKindOfClass:NSClassFromString(@#__RHS__)] == NO) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not kind of class %s", #__LHS__, #__RHS__) \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert an object is kind of class
#define FLConfirmIsKindOfClass_v(__LHS__, __RHS__, __COMMENT__, ...) \
    if([__LHS__ isKindOfClass:NSClassFromString(@#__RHS__)] == NO) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not kind of class %s", #__LHS__, #__RHS__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert an object is kind of class
#define FLCConfirmIsKindOfClass_v(__LHS__, __RHS__, __COMMENT__, ...) \
    if([__LHS__ isKindOfClass:NSClassFromString(@#__RHS__)] == NO) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeAreEqual \
            userInfo:nil \
            reason:FLStringWithFormatOrNil(@"%sis unexpectedly not kind of class %s", #__LHS__, #__RHS__) \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert code is implemented
#define FLConfirmIsImplemented_() \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeNotImplemented \
            userInfo:nil \
            reason:nil \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert code is implemented
#define FLCConfirmIsImplemented_() \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeNotImplemented \
            userInfo:nil \
            reason:nil \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert code is implemented
#define FLConfirmIsImplemented_v(__COMMENT__, ...) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeNotImplemented \
            userInfo:nil \
            reason:nil \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert code is implemented
#define FLCConfirmIsImplemented_v(__COMMENT__, ...) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeNotImplemented \
            userInfo:nil \
            reason:nil \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert if the code isn't fixed
#define FLConfirmIsFixed_() \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeFixMe \
            userInfo:nil \
            reason:nil \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert if the code isn't fixed
#define FLCConfirmIsFixed_() \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeFixMe \
            userInfo:nil \
            reason:nil \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert if the code isn't fixed
#define FLConfirmIsFixed_v(__COMMENT__, ...) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeFixMe \
            userInfo:nil \
            reason:nil \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assert if the code isn't fixed
#define FLCConfirmIsFixed_v(__COMMENT__, ...) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeFixMe \
            userInfo:nil \
            reason:nil \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assertion fails because there's known bug here
#define FLConfirmIsBug_() \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeBug \
            userInfo:nil \
            reason:nil \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assertion fails because there's known bug here
#define FLCConfirmIsBug_() \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeBug \
            userInfo:nil \
            reason:nil \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assertion fails because there's known bug here
#define FLConfirmIsBug_v(__COMMENT__, ...) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeBug \
            userInfo:nil \
            reason:nil \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: Assertion fails because there's known bug here
#define FLCConfirmIsBug_v(__COMMENT__, ...) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeBug \
            userInfo:nil \
            reason:nil \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: clients of this code must override this
#define FLConfirmIsOverridden_() \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeRequiredOverride \
            userInfo:nil \
            reason:nil \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: clients of this code must override this
#define FLCConfirmIsOverridden_() \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeRequiredOverride \
            userInfo:nil \
            reason:nil \
            comment:nil \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: clients of this code must override this
#define FLConfirmIsOverridden_v(__COMMENT__, ...) \
        FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeRequiredOverride \
            userInfo:nil \
            reason:nil \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


/// @brief: clients of this code must override this
#define FLCConfirmIsOverridden_v(__COMMENT__, ...) \
        FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
            code:FLFailureTypeRequiredOverride \
            userInfo:nil \
            reason:nil \
            comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
            stackTrace:FLCreateStackTrace(YES)]) \


