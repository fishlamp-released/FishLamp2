//
//  FLScopeStringBuilder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCocoaRequired.h"
#import "FLWhitespace.h"
#import "FLStringFormatter.h"
#import "FLStringBuilder.h"
#import "FLPrettyString.h"
#import "FLStringDocument.h"

@interface FLDocumentBuilder : FLStringFormatter<FLStringFormatterDelegate, FLBuildableString> {
@private
    FLStringDocument* _document;
}
+ (id) documentBuilder;

@property (readonly, strong, nonatomic) FLStringDocument* document;
@property (readonly, strong, nonatomic) FLStringBuilder* openedSection;

- (void) openSection:(FLStringBuilder*) element;
- (void) addSection:(FLStringBuilder*) element;
- (void) closeSection;

- (void) closeAllSections;

@end

