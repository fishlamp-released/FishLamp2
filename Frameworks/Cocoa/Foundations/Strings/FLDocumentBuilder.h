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
#import "FLDocumentSection.h"
#import "FLPrettyString.h"
#import "FLStringDocument.h"

@interface FLDocumentBuilder : FLStringFormatter<FLBuildableString> {
@private
    FLStringDocument* _document;
}
+ (id) documentBuilder;

@property (readonly, strong, nonatomic) FLStringDocument* document;
@property (readonly, strong, nonatomic) FLDocumentSection* openedSection;

- (void) openSection:(FLDocumentSection*) element;
- (void) addSection:(FLDocumentSection*) element;
- (void) closeSection;

- (void) closeAllSections;

@end

