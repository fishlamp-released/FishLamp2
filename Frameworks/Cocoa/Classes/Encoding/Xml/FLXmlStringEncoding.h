//
//  FLXmlStringEncoding.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLStringEncoder.h"
#import "NSString+XML.h"

@interface FLXmlStringEncoder : NSObject<FLStringEncoding>
+ (id) xmlStringEncoder;
@end


@interface FLXmlURLStringEncoder : FLURLStringEncoder
+ (id) xmlURLStringEncoder;
@end
