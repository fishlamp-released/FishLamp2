//
//  FLObjcContainerSubType.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FLObjcType;

@interface FLObjcContainerSubType : NSObject {
@private
    NSString* _subTypeName;
    FLObjcType* _arrayElementType;
}

@property (readwrite, strong, nonatomic) NSString* subTypeName;
@property (readwrite, strong, nonatomic) FLObjcType* objcType;

+ (id) objcContainerSubType:(NSString*) name 
                   objcType:(FLObjcType*) objcType;

@end
