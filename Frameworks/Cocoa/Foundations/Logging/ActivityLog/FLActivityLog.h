//
//  FLActivityLog.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/2/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLStringFormatter.h"

@protocol FLActivityLog <FLStringFormatter>

@property (readonly, strong, nonatomic) NSString* string;
@property (readonly, strong, nonatomic) NSAttributedString* attributedString;
@end

@interface FLActivityLog : FLStringFormatter<FLActivityLog, FLStringFormatterDelegate> {
@private 
    FLPrettyAttributedString* _log;
}

FLSingletonProperty(FLActivityLog);

- (NSError*) exportToPath:(NSURL*) url;

@end

@protocol FLActivityLogDelegate <NSObject>
- (void) activityLog:(FLActivityLog*) activityLog wasUpdated:(NSString*) line;
@end


