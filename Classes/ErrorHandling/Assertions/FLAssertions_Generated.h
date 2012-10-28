// Generated at: 2012-09-14 22:02:46 +0000
#if DEBUG
    /// @brief: Assert that any condition is true
    #define FLAssert_(__CONDITION__) \
        if((__CONDITION__) == NO) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeCondition \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__CONDITION__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssert_(__CONDITION__)
#endif

#if DEBUG
    /// @brief: Assert that any condition is true
    #define FLCAssert_(__CONDITION__) \
        if((__CONDITION__) == NO) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeCondition \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__CONDITION__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssert_(__CONDITION__)
#endif

#if DEBUG
    /// @brief: Assert that any condition is true
    #define FLAssert_v(__CONDITION__, __COMMENT__, ...) \
        if((__CONDITION__) == NO) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeCondition \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__CONDITION__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssert_v(__CONDITION__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert that any condition is true
    #define FLCAssert_v(__CONDITION__, __COMMENT__, ...) \
        if((__CONDITION__) == NO) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeCondition \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__CONDITION__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssert_v(__CONDITION__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: This will throw an diction failure exception
    #define FLAssertFailed_() \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeCondition \
                userInfo:nil \
                reason:nil \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertFailed_()
#endif

#if DEBUG
    /// @brief: This will throw an diction failure exception
    #define FLCAssertFailed_() \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeCondition \
                userInfo:nil \
                reason:nil \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertFailed_()
#endif

#if DEBUG
    /// @brief: This will throw an diction failure exception
    #define FLAssertFailed_v(__COMMENT__, ...) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeCondition \
                userInfo:nil \
                reason:nil \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertFailed_v(__COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: This will throw an diction failure exception
    #define FLCAssertFailed_v(__COMMENT__, ...) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeCondition \
                userInfo:nil \
                reason:nil \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertFailed_v(__COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert a pointer is nil
    #define FLAssertIsNil_(__CONDITION__) \
        if((__CONDITION__) != nil) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsNil \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Pointer unexpectedly not nil: %s", #__CONDITION__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsNil_(__CONDITION__)
#endif

#if DEBUG
    /// @brief: Assert a pointer is nil
    #define FLCAssertIsNil_(__CONDITION__) \
        if((__CONDITION__) != nil) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsNil \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Pointer unexpectedly not nil: %s", #__CONDITION__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsNil_(__CONDITION__)
#endif

#if DEBUG
    /// @brief: Assert a pointer is nil
    #define FLAssertIsNil_v(__CONDITION__, __COMMENT__, ...) \
        if((__CONDITION__) != nil) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsNil \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Pointer unexpectedly not nil: %s", #__CONDITION__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsNil_v(__CONDITION__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert a pointer is nil
    #define FLCAssertIsNil_v(__CONDITION__, __COMMENT__, ...) \
        if((__CONDITION__) != nil) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsNil \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Pointer unexpectedly not nil: %s", #__CONDITION__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsNil_v(__CONDITION__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert a pointer is NOT nil
    #define FLAssertIsNotNil_(__CONDITION__) \
        if((__CONDITION__) == nil) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsNotNil \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Pointer unexpectedly nil: %s", #__CONDITION__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsNotNil_(__CONDITION__)
#endif

#if DEBUG
    /// @brief: Assert a pointer is NOT nil
    #define FLCAssertIsNotNil_(__CONDITION__) \
        if((__CONDITION__) == nil) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsNotNil \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Pointer unexpectedly nil: %s", #__CONDITION__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsNotNil_(__CONDITION__)
#endif

#if DEBUG
    /// @brief: Assert a pointer is NOT nil
    #define FLAssertIsNotNil_v(__CONDITION__, __COMMENT__, ...) \
        if((__CONDITION__) == nil) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsNotNil \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Pointer unexpectedly nil: %s", #__CONDITION__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsNotNil_v(__CONDITION__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert a pointer is NOT nil
    #define FLCAssertIsNotNil_v(__CONDITION__, __COMMENT__, ...) \
        if((__CONDITION__) == nil) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsNotNil \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Pointer unexpectedly nil: %s", #__CONDITION__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsNotNil_v(__CONDITION__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert a string is empty (either nil or of length 0)
    /// empty is either nil or of zero length
    #define FLAssertStringIsNotEmpty_(__STRING__) \
        if(FLStringIsEmpty(__STRING__)) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsEmpty \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"String unexpectedly empty: %s", #__STRING__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertStringIsNotEmpty_(__STRING__)
#endif

#if DEBUG
    /// @brief: Assert a string is empty (either nil or of length 0)
    /// empty is either nil or of zero length
    #define FLCAssertStringIsNotEmpty_(__STRING__) \
        if(FLStringIsEmpty(__STRING__)) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsEmpty \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"String unexpectedly empty: %s", #__STRING__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertStringIsNotEmpty_(__STRING__)
#endif

#if DEBUG
    /// @brief: Assert a string is empty (either nil or of length 0)
    /// empty is either nil or of zero length
    #define FLAssertStringIsNotEmpty_v(__STRING__, __COMMENT__, ...) \
        if(FLStringIsEmpty(__STRING__)) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsEmpty \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"String unexpectedly empty: %s", #__STRING__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertStringIsNotEmpty_v(__STRING__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert a string is empty (either nil or of length 0)
    /// empty is either nil or of zero length
    #define FLCAssertStringIsNotEmpty_v(__STRING__, __COMMENT__, ...) \
        if(FLStringIsEmpty(__STRING__)) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsEmpty \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"String unexpectedly empty: %s", #__STRING__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertStringIsNotEmpty_v(__STRING__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert a string is NOT empty
    /// empty is either nil or of zero length
    #define FLAssertStringIsEmpty_(__STRING__) \
        if((FLStringIsNotEmpty(__STRING__)) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsNotEmpty \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"String unexpectedly not empty: %s", #__STRING__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertStringIsEmpty_(__STRING__)
#endif

#if DEBUG
    /// @brief: Assert a string is NOT empty
    /// empty is either nil or of zero length
    #define FLCAssertStringIsEmpty_(__STRING__) \
        if((FLStringIsNotEmpty(__STRING__)) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsNotEmpty \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"String unexpectedly not empty: %s", #__STRING__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertStringIsEmpty_(__STRING__)
#endif

#if DEBUG
    /// @brief: Assert a string is NOT empty
    /// empty is either nil or of zero length
    #define FLAssertStringIsEmpty_v(__STRING__, __COMMENT__, ...) \
        if((FLStringIsNotEmpty(__STRING__)) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsNotEmpty \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"String unexpectedly not empty: %s", #__STRING__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertStringIsEmpty_v(__STRING__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert a string is NOT empty
    /// empty is either nil or of zero length
    #define FLCAssertStringIsEmpty_v(__STRING__, __COMMENT__, ...) \
        if((FLStringIsNotEmpty(__STRING__)) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsNotEmpty \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"String unexpectedly not empty: %s", #__STRING__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertStringIsEmpty_v(__STRING__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert a BOOL is true
    /// the is the same as AssertYes
    #define FLAssertIsTrue_(__BOOL__) \
        if((__BOOL__) == NO) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsFalse \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__BOOL__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsTrue_(__BOOL__)
#endif

#if DEBUG
    /// @brief: Assert a BOOL is true
    /// the is the same as AssertYes
    #define FLCAssertIsTrue_(__BOOL__) \
        if((__BOOL__) == NO) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsFalse \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__BOOL__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsTrue_(__BOOL__)
#endif

#if DEBUG
    /// @brief: Assert a BOOL is true
    /// the is the same as AssertYes
    #define FLAssertIsTrue_v(__BOOL__, __COMMENT__, ...) \
        if((__BOOL__) == NO) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsFalse \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__BOOL__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsTrue_v(__BOOL__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert a BOOL is true
    /// the is the same as AssertYes
    #define FLCAssertIsTrue_v(__BOOL__, __COMMENT__, ...) \
        if((__BOOL__) == NO) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsFalse \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly false: %s", #__BOOL__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsTrue_v(__BOOL__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert a BOOL is false
    /// this is the same as AssertNo
    #define FLAssertIsFalse_(__BOOL__) \
        if((__BOOL__) == YES) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsTrue \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly true: %s", #__BOOL__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsFalse_(__BOOL__)
#endif

#if DEBUG
    /// @brief: Assert a BOOL is false
    /// this is the same as AssertNo
    #define FLCAssertIsFalse_(__BOOL__) \
        if((__BOOL__) == YES) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsTrue \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly true: %s", #__BOOL__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsFalse_(__BOOL__)
#endif

#if DEBUG
    /// @brief: Assert a BOOL is false
    /// this is the same as AssertNo
    #define FLAssertIsFalse_v(__BOOL__, __COMMENT__, ...) \
        if((__BOOL__) == YES) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsTrue \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly true: %s", #__BOOL__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsFalse_v(__BOOL__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert a BOOL is false
    /// this is the same as AssertNo
    #define FLCAssertIsFalse_v(__BOOL__, __COMMENT__, ...) \
        if((__BOOL__) == YES) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsTrue \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly true: %s", #__BOOL__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsFalse_v(__BOOL__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert a BOOL is YES
    /// this is the same as AssertTrue
    #define FLAssertIsYes_(__BOOL__) \
        if((__BOOL__) == NO) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsFalse \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly NO: %s", #__BOOL__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsYes_(__BOOL__)
#endif

#if DEBUG
    /// @brief: Assert a BOOL is YES
    /// this is the same as AssertTrue
    #define FLCAssertIsYes_(__BOOL__) \
        if((__BOOL__) == NO) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsFalse \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly NO: %s", #__BOOL__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsYes_(__BOOL__)
#endif

#if DEBUG
    /// @brief: Assert a BOOL is YES
    /// this is the same as AssertTrue
    #define FLAssertIsYes_v(__BOOL__, __COMMENT__, ...) \
        if((__BOOL__) == NO) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsFalse \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly NO: %s", #__BOOL__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsYes_v(__BOOL__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert a BOOL is YES
    /// this is the same as AssertTrue
    #define FLCAssertIsYes_v(__BOOL__, __COMMENT__, ...) \
        if((__BOOL__) == NO) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsFalse \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly NO: %s", #__BOOL__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsYes_v(__BOOL__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert a BOOL is NO
    /// this is the same as AssertNO
    #define FLAssertIsNo_(__BOOL__) \
        if((__BOOL__) == YES) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsTrue \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly YES: %s", #__BOOL__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsNo_(__BOOL__)
#endif

#if DEBUG
    /// @brief: Assert a BOOL is NO
    /// this is the same as AssertNO
    #define FLCAssertIsNo_(__BOOL__) \
        if((__BOOL__) == YES) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsTrue \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly YES: %s", #__BOOL__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsNo_(__BOOL__)
#endif

#if DEBUG
    /// @brief: Assert a BOOL is NO
    /// this is the same as AssertNO
    #define FLAssertIsNo_v(__BOOL__, __COMMENT__, ...) \
        if((__BOOL__) == YES) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsTrue \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly YES: %s", #__BOOL__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsNo_v(__BOOL__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert a BOOL is NO
    /// this is the same as AssertNO
    #define FLCAssertIsNo_v(__BOOL__, __COMMENT__, ...) \
        if((__BOOL__) == YES) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeIsTrue \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"Condition unexpectedly YES: %s", #__BOOL__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsNo_v(__BOOL__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert values are equal
    /// a value is anything that can be compared with ==
    #define FLAssertAreEqual_(__LHS__, __RHS__) \
        if((__LHS__) != (__RHS__)) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreNotEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertAreEqual_(__LHS__, __RHS__)
#endif

#if DEBUG
    /// @brief: Assert values are equal
    /// a value is anything that can be compared with ==
    #define FLCAssertAreEqual_(__LHS__, __RHS__) \
        if((__LHS__) != (__RHS__)) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreNotEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertAreEqual_(__LHS__, __RHS__)
#endif

#if DEBUG
    /// @brief: Assert values are equal
    /// a value is anything that can be compared with ==
    #define FLAssertAreEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
        if((__LHS__) != (__RHS__)) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreNotEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertAreEqual_v(__LHS__, __RHS__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert values are equal
    /// a value is anything that can be compared with ==
    #define FLCAssertAreEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
        if((__LHS__) != (__RHS__)) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreNotEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertAreEqual_v(__LHS__, __RHS__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert values are NOT equal
    /// a value is anything that can be compared with !=
    #define FLAssertAreNotEqual_(__LHS__, __RHS__) \
        if((__LHS__) == (__RHS__)) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertAreNotEqual_(__LHS__, __RHS__)
#endif

#if DEBUG
    /// @brief: Assert values are NOT equal
    /// a value is anything that can be compared with !=
    #define FLCAssertAreNotEqual_(__LHS__, __RHS__) \
        if((__LHS__) == (__RHS__)) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertAreNotEqual_(__LHS__, __RHS__)
#endif

#if DEBUG
    /// @brief: Assert values are NOT equal
    /// a value is anything that can be compared with !=
    #define FLAssertAreNotEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
        if((__LHS__) == (__RHS__)) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertAreNotEqual_v(__LHS__, __RHS__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert values are NOT equal
    /// a value is anything that can be compared with !=
    #define FLCAssertAreNotEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
        if((__LHS__) == (__RHS__)) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertAreNotEqual_v(__LHS__, __RHS__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert objects are equal
    /// this uses [NSObject isEqual] for the comparison
    #define FLAssertObjectsAreEqual_(__LHS__, __RHS__) \
        if([(__LHS__) isEqual:(__RHS__)] == NO) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreNotEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertObjectsAreEqual_(__LHS__, __RHS__)
#endif

#if DEBUG
    /// @brief: Assert objects are equal
    /// this uses [NSObject isEqual] for the comparison
    #define FLCAssertObjectsAreEqual_(__LHS__, __RHS__) \
        if([(__LHS__) isEqual:(__RHS__)] == NO) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreNotEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertObjectsAreEqual_(__LHS__, __RHS__)
#endif

#if DEBUG
    /// @brief: Assert objects are equal
    /// this uses [NSObject isEqual] for the comparison
    #define FLAssertObjectsAreEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
        if([(__LHS__) isEqual:(__RHS__)] == NO) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreNotEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertObjectsAreEqual_v(__LHS__, __RHS__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert objects are equal
    /// this uses [NSObject isEqual] for the comparison
    #define FLCAssertObjectsAreEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
        if([(__LHS__) isEqual:(__RHS__)] == NO) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreNotEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly not equal to %s", #__LHS__, #__RHS__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertObjectsAreEqual_v(__LHS__, __RHS__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert objects are not equal
    /// this uses [NSObject isEqual] for the comparison
    #define FLAssertObjectsAreNotEqual_(__LHS__, __RHS__) \
        if([(__LHS__) isEqual:(__RHS__)] == YES) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertObjectsAreNotEqual_(__LHS__, __RHS__)
#endif

#if DEBUG
    /// @brief: Assert objects are not equal
    /// this uses [NSObject isEqual] for the comparison
    #define FLCAssertObjectsAreNotEqual_(__LHS__, __RHS__) \
        if([(__LHS__) isEqual:(__RHS__)] == YES) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertObjectsAreNotEqual_(__LHS__, __RHS__)
#endif

#if DEBUG
    /// @brief: Assert objects are not equal
    /// this uses [NSObject isEqual] for the comparison
    #define FLAssertObjectsAreNotEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
        if([(__LHS__) isEqual:(__RHS__)] == YES) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertObjectsAreNotEqual_v(__LHS__, __RHS__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert objects are not equal
    /// this uses [NSObject isEqual] for the comparison
    #define FLCAssertObjectsAreNotEqual_v(__LHS__, __RHS__, __COMMENT__, ...) \
        if([(__LHS__) isEqual:(__RHS__)] == YES) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly equal to %s", #__LHS__, #__RHS__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertObjectsAreNotEqual_v(__LHS__, __RHS__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert an object is kind of class
    #define FLAssertIsKindOfClass_(__LHS__, __RHS__) \
        if([__LHS__ isKindOfClass:NSClassFromString(@#__RHS__)] == NO) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly not kind of class %s", #__LHS__, #__RHS__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsKindOfClass_(__LHS__, __RHS__)
#endif

#if DEBUG
    /// @brief: Assert an object is kind of class
    #define FLCAssertIsKindOfClass_(__LHS__, __RHS__) \
        if([__LHS__ isKindOfClass:NSClassFromString(@#__RHS__)] == NO) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly not kind of class %s", #__LHS__, #__RHS__) \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsKindOfClass_(__LHS__, __RHS__)
#endif

#if DEBUG
    /// @brief: Assert an object is kind of class
    #define FLAssertIsKindOfClass_v(__LHS__, __RHS__, __COMMENT__, ...) \
        if([__LHS__ isKindOfClass:NSClassFromString(@#__RHS__)] == NO) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly not kind of class %s", #__LHS__, #__RHS__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsKindOfClass_v(__LHS__, __RHS__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert an object is kind of class
    #define FLCAssertIsKindOfClass_v(__LHS__, __RHS__, __COMMENT__, ...) \
        if([__LHS__ isKindOfClass:NSClassFromString(@#__RHS__)] == NO) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeAreEqual \
                userInfo:nil \
                reason:FLStringWithFormatOrNil(@"%sis unexpectedly not kind of class %s", #__LHS__, #__RHS__) \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsKindOfClass_v(__LHS__, __RHS__, __COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert code is implemented
    #define FLAssertIsImplemented_() \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeNotImplemented \
                userInfo:nil \
                reason:nil \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsImplemented_()
#endif

#if DEBUG
    /// @brief: Assert code is implemented
    #define FLCAssertIsImplemented_() \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeNotImplemented \
                userInfo:nil \
                reason:nil \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsImplemented_()
#endif

#if DEBUG
    /// @brief: Assert code is implemented
    #define FLAssertIsImplemented_v(__COMMENT__, ...) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeNotImplemented \
                userInfo:nil \
                reason:nil \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsImplemented_v(__COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert code is implemented
    #define FLCAssertIsImplemented_v(__COMMENT__, ...) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeNotImplemented \
                userInfo:nil \
                reason:nil \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsImplemented_v(__COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert if the code isn't fixed
    #define FLAssertIsFixed_() \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeFixMe \
                userInfo:nil \
                reason:nil \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsFixed_()
#endif

#if DEBUG
    /// @brief: Assert if the code isn't fixed
    #define FLCAssertIsFixed_() \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeFixMe \
                userInfo:nil \
                reason:nil \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsFixed_()
#endif

#if DEBUG
    /// @brief: Assert if the code isn't fixed
    #define FLAssertIsFixed_v(__COMMENT__, ...) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeFixMe \
                userInfo:nil \
                reason:nil \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsFixed_v(__COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assert if the code isn't fixed
    #define FLCAssertIsFixed_v(__COMMENT__, ...) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeFixMe \
                userInfo:nil \
                reason:nil \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsFixed_v(__COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assertion fails because there's known bug here
    #define FLAssertIsBug_() \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeBug \
                userInfo:nil \
                reason:nil \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsBug_()
#endif

#if DEBUG
    /// @brief: Assertion fails because there's known bug here
    #define FLCAssertIsBug_() \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeBug \
                userInfo:nil \
                reason:nil \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsBug_()
#endif

#if DEBUG
    /// @brief: Assertion fails because there's known bug here
    #define FLAssertIsBug_v(__COMMENT__, ...) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeBug \
                userInfo:nil \
                reason:nil \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsBug_v(__COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: Assertion fails because there's known bug here
    #define FLCAssertIsBug_v(__COMMENT__, ...) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeBug \
                userInfo:nil \
                reason:nil \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsBug_v(__COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: clients of this code must override this
    #define FLAssertIsOverridden_() \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeRequiredOverride \
                userInfo:nil \
                reason:nil \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsOverridden_()
#endif

#if DEBUG
    /// @brief: clients of this code must override this
    #define FLCAssertIsOverridden_() \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeRequiredOverride \
                userInfo:nil \
                reason:nil \
                comment:nil \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsOverridden_()
#endif

#if DEBUG
    /// @brief: clients of this code must override this
    #define FLAssertIsOverridden_v(__COMMENT__, ...) \
            FLThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeRequiredOverride \
                userInfo:nil \
                reason:nil \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLAssertIsOverridden_v(__COMMENT__, ...)
#endif

#if DEBUG
    /// @brief: clients of this code must override this
    #define FLCAssertIsOverridden_v(__COMMENT__, ...) \
            FLCThrowError_([FLMutableError errorWithDomain:[FLAssertionFailureErrorDomain instance] \
                code:FLFailureTypeRequiredOverride \
                userInfo:nil \
                reason:nil \
                comment: FLStringWithFormatOrNil(__COMMENT__, ##__VA_ARGS__) \
                stackTrace:FLCreateStackTrace(YES)]) \

#else
    #define FLCAssertIsOverridden_v(__COMMENT__, ...)
#endif

