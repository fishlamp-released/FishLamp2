//
//  FLCodeIdentifier.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeIdentifier.h"

@interface FLCodeIdentifier ()
@property (readwrite, strong, nonatomic) NSString* identifierName;
@property (readwrite, strong, nonatomic) NSString* prefix;
@property (readwrite, strong, nonatomic) NSString* suffix;
@end

@implementation FLCodeIdentifier

@synthesize identifierName = _identifierName;
@synthesize prefix = _prefix;
@synthesize suffix = _suffix;

//- (id) init {	
//    return [self initWithName:@""];
//}

- (id) initWithIdentifierName:(NSString*) name  
                       prefix:(NSString*) prefix 
                       suffix:(NSString*) suffix {	
	self = [super init];
	if(self) {

        FLAssertStringIsNotEmpty(name);
        
        if(!prefix) {
            prefix = @"";
        }
        if(!suffix) {
            suffix = @"";
        }
        
        if(prefix.length && [name hasPrefix:prefix]) {
            name = [name substringFromIndex:prefix.length];
        }

        if(suffix.length && [name hasSuffix:suffix]) {
            name = [name substringToIndex:(name.length - suffix.length)];
        }

        self.prefix = prefix;
        self.suffix = suffix;
        self.identifierName = name;
	}
	return self;
}

- (NSString*) generatedName {
    return [NSString stringWithFormat:@"%@%@%@", _prefix, _identifierName, _suffix];
}

- (NSString*) generatedReference {
    return [self generatedName];
}

- (id) copyWithZone:(NSZone *)zone {
    FLCodeIdentifier* name = [[[self class] alloc] init];
    name.identifierName = FLCopyWithAutorelease(self.identifierName);
    name.prefix = FLCopyWithAutorelease(self.prefix);
    name.suffix = FLCopyWithAutorelease(self.suffix);
    return name;
}

- (BOOL)isEqual:(FLCodeIdentifier*)object {
    return FLStringsAreEqual(self.identifierName, [object identifierName]);
}

- (NSUInteger)hash {
    return [self.identifierName hash];
}

#if FL_MRC
- (void) dealloc {
	[_identifierName release];
    [_prefix release];
    [_suffix release];
    [super dealloc];
}
#endif

- (NSString*) description {
    return [NSString stringWithFormat:@"identifier: %@", self.generatedName];
}

@end
