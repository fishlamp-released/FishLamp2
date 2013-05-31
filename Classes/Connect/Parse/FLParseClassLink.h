//
//  FLParseClassLink.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 5/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLParseClassLink : NSObject {
@private
    NSString* _objectClass;
    NSString* _objectId;
}

@property (readonly, strong, nonatomic) NSString* encodedString;
@property (readonly, strong, nonatomic) NSString* objectId;
@property (readonly, strong, nonatomic) NSString* objectClass;

+ (id) parseClassLink:(NSString*) encoded;

+ (id) parseClassLink:(Class) aClass objectId:(NSString*) objectId;


@end
