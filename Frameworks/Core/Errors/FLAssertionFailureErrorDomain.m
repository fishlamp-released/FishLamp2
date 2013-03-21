//
//  FLAssertionFailureErrorDomain.m
//  FishLampSync
//
//  Created by Mike Fullerton on 11/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAssertionFailureErrorDomain.h"
NSString* const FLAssertionFailureErrorDomain = @"com.fishlamp.assertion-failure";

@implementation FLAssertionFailureErrorDomainInfo

+ (id) assertionFailureErrorDomainInfo {
    return FLAutorelease([[[self class] alloc] init]);
}

- (NSString*) stringFromErrorCode:(int) errorCode {
    switch(errorCode) {
        case FLAssertionFailureNone:
        break;
        case FLAssertionFailureCondition:
            return @"com.fishlamp.assertion-failure.condition";
        break;
        case FLAssertionFailureAreEqual:
            return @"com.fishlamp.assertion-failure.equal";
        break;
        case FLAssertionFailureAreNotEqual:
            return @"com.fishlamp.assertion-failure.not-equal";
        break;
        case FLAssertionFailureIsNil:
            return @"com.fishlamp.assertion-failure.nil";
        break;
        case FLAssertionFailureIsNotNil:
            return @"com.fishlamp.assertion-failure.not-nil";
        break;
        case FLAssertionFailureIsEmpty:
            return @"com.fishlamp.assertion-failure.is-empty";
        break;
        case FLAssertionFailureIsNotEmpty:
            return @"com.fishlamp.assertion-failure.not-empty";
        break;
        case FLAssertionFailureIsTrue:
            return @"com.fishlamp.assertion-failure.is-true";
        break;
        case FLAssertionFailureIsFalse:
            return @"com.fishlamp.assertion-failure.is-false";
        break;
        case FLAssertionFailureIsWrongType:
            return @"com.fishlamp.assertion-failure.wrong-type";
        break;
        case FLAssertionFailureUnsupportedInit:
            return @"com.fishlamp.assertion-failure.unsupported-init";
        break;
        case FLAssertionFailureNotImplemented:
            return @"com.fishlamp.assertion-failure.unimplemented";
        break;
        case FLAssertionFailureFixMe:
            return @"com.fishlamp.assertion-failure.fixme";
        break;
        case FLAssertionFailureBug:
            return @"com.fishlamp.assertion-failure.bug";
        break;
        case FLAssertionFailureRequiredOverride:
            return @"com.fishlamp.assertion-failure.required-override";
        break;
    }
    
    return @"";
}

- (NSString*) errorDomainString {
    return @"com.fishlamp.assertion-failure";
}


@end
#if 0

#define FLFailureErrorDomainUrl @"com.fishlamp.assertion"

static NSString* s_failStrings[] = {
    @"no-failure",
    @"condition-failure",
    @"equal-failure",
    @"not-equal-failure",
    @"nil-pointer-failure",
    @"non-nil-pointer-failure",
    @"empty-failure",
    @"not-empty-failure",
    @"true-failure",
    @"false-failure",
    @"wrong-type-failure",
    @"unsupported-init-failure",
    @"not-implemented-failure",
    @"fixme-failure",
    @"bug-failure",
    @"required-override-failure"
};

NSString* FLStringFromFailureType(FLAssertionFailure type) {
    if(type <= FLAssertionFailureRequiredOverride) {
        return s_failStrings[type];
    }
    return nil;
}

static NSString* s_defaultCommentStrings[] = {
    @"nothing",
    @"A condition failed.",
    @"these two things should NOT be the same (they are)",
    @"these two things should be the same (they're not)",
    @"a pointer is nil",
    @"a pointer is NOT nil",
    @"was expecting it to be empty",
    @"was expecting it NOT to be empty",
    @"this should be equal to NO",
    @"this should be equal to YES",
    @"was expecting a different object type",
    @"you shouldn't call this default init",
    nil,
    @"something bad is happening here, fix it",
    @"there's a known bug here",
    @"you MUST override this method"
};

NSString* _FLStringWithTag(NSString* tag, NSString* string) {
    return FLStringIsNotEmpty(string) ? [NSString stringWithFormat:@", %@=\"%@\"", tag, string] : @"";
}

NSString* _FLFormatOptionalAssertComment(NSString* args, FLAssertionFailure type) {
    if(FLStringIsEmpty(args) || [args isEqual:@"\"\""]) {
        return @"";
    }
    else {
        return args;
    }
}

NSString* _FLFormatOptionalReason(NSString* args, FLAssertionFailure type) {
    if(FLStringIsEmpty(args) || [args isEqual:@"\"\""]) {
        args = s_defaultCommentStrings[type];
    }
    if(!args) {
        return @"";
    }
    
    return args;
}

NSString* _FLAssembleFailureReason(NSString* name,
                                   NSString* reason,
                                   NSString* comment,
                                   FLStackTrace* location) {
       
//    if(location.className) {
//        return [NSString stringWithFormat:@"%@%@%@%@%@",
//                            name,
//                            _FLStringWithTag(@"reason", reason),
//                            _FLStringWithTag(@"comment", comment),
//                            _FLStringWithTag(@"file", [NSString stringWithFormat:@"%@, %d", location.fileName, location.line]),
//                            _FLStringWithTag(@"objc", [NSString stringWithFormat:@"[%@ %@]",location.className, location.cmdName])];
//    }
//    else {
//        return [NSString stringWithFormat:@"%@%@%@%@",
//                            name,
//                            _FLStringWithTag(@"reason", reason),
//                            _FLStringWithTag(@"comment", comment),
//                            _FLStringWithTag(@"file", [NSString stringWithFormat:@"%@, %d", location.fileName, location.line])];
//    
//    }

    return @"";
}
#endif