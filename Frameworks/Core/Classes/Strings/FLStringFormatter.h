//
//  FLAbstractStringBuilder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLStringFormatterProtocol.h"
#import "FLAbstractStringAppender.h"

@protocol FLStringFormatterOutput;

@interface FLStringFormatter : FLAbstractStringAppender<FLStringFormatter> {
@private
    BOOL _editingLine;
    __unsafe_unretained id<FLStringFormatterOutput> _output;
    __unsafe_unretained id _parent;
}
@property (readwrite, assign, nonatomic) id parent;

@property (readwrite, nonatomic, assign) id<FLStringFormatterOutput> stringFormatterOutput;

- (void) didMoveToParent:(id) parent;

@end

@protocol FLStringFormatterOutput <NSObject>
- (void) stringFormatterAppendBlankLine:(FLStringFormatter*) stringFormatter;
- (void) stringFormatterOpenLine:(FLStringFormatter*) stringFormatter;
- (void) stringFormatterCloseLine:(FLStringFormatter*) stringFormatter;
- (void) stringFormatter:(FLStringFormatter*) stringFormatter appendString:(NSString*) string;
- (void) stringFormatter:(FLStringFormatter*) stringFormatter appendAttributedString:(NSAttributedString*) attributedString;
- (void) stringFormatterIndent:(FLStringFormatter*) stringFormatter;
- (void) stringFormatterOutdent:(FLStringFormatter*) stringFormatter;
- (NSUInteger) stringFormatterGetLength:(FLStringFormatter*) stringFormatter;
- (void) stringFormatter:(FLStringFormatter*) stringFormatter
appendSelfToStringFormatter:(id<FLStringFormatter>) anotherStringFormatter;
@end


