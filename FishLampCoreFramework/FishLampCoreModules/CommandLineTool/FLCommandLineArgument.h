//
//  FLCommandLineArgument.h
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLCommandLineArgument : NSObject {
@private
    NSString* _key;
    NSMutableArray* _values;
}

@property (readonly, strong, nonatomic) NSString* key;
@property (readonly, strong, nonatomic) NSArray* values;

- (id) initWithKey:(NSString*) key;
+ (id) commandLineArgument:(NSString*) key;

- (void) addValue:(NSString*) param;

@end


