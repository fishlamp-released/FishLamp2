//
//  FLAssertions.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAssertions.h"

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

NSString* FLStringFromFailureType(FLFailureType type) {
    if(type <= FLFailureTypeRequiredOverride) {
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

NSString* _FLFormatOptionalAssertComment(NSString* args, FLFailureType type) {
    if(FLStringIsEmpty(args) || [args isEqual:@"\"\""]) {
        return @"";
    }
    else {
        return args;
    }
}

NSString* _FLFormatOptionalReason(NSString* args, FLFailureType type) {
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

FLSynthesizeErrorDomain(FLAssertionFailureErrorDomain, @"com.fishlamp.assertion");

@implementation FLAssertionFailureErrorDomain (Error)

- (NSString*) descriptionForError:(NSError*) error {

    return nil;
}

@end

//@implementation FLAssertionFailureErrorDomain
//
//FLSynthesizeErrorDomainProperties(FLAssertionFailureErrorDomain, FLFailureErrorDomainUrl);
//
//
//@end

