//
//  GtKeywordListFormatter.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/13/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GtDisplayFormatter.h"

@interface GtKeywordListFormatter : NSObject<GtDisplayFormatterProtocol> {}
@end

@interface GtStringFormatter : NSObject<GtDisplayFormatterProtocol> {}
@end

@interface GtIntFormatter : NSObject<GtDisplayFormatterProtocol> {}
@end

@interface GtLongFormatter : NSObject<GtDisplayFormatterProtocol> {}
@end

@interface GtDateFormatter : NSObject<GtDisplayFormatterProtocol> {
     NSDateFormatter* m_dateFormatter;
}

GtSingletonProperty(GtDateFormatter);
@end

@interface GtBytesDataSizeFormatter : NSObject<GtDisplayFormatterProtocol> {}
@end

@interface GtKilobytesDataSizeFormatter : GtBytesDataSizeFormatter {}
@end

@interface GtObjectDescriptionFormatter : NSObject<GtDisplayFormatterProtocol> {}
@end

@interface GtSimpleHtmlFormatter : NSObject<GtDisplayFormatterProtocol> {}
@end