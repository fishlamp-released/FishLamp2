//
//  FLObjcStatement.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcCodeElement.h"
#import "FLObjcCodeBuilder.h"

@class FLObjcRuntimeValue;

@interface FLObjcStatement : NSObject<FLObjcCodeElement> 
//+ (id) objcStatement:(FLObjcTypeIndex*) typeIndex;
@end

@interface FLObjcReturnStatement : FLObjcStatement {
@private
    FLObjcRuntimeValue* _value;
}
@property (readwrite, strong, nonatomic) FLObjcRuntimeValue* returnValue;

+ (id) objcReturnStatement:(FLObjcRuntimeValue*) returnValue;


@end

@interface FLObjcBlockStatement : FLObjcStatement {
@private
    NSMutableArray* _statements;
}
@property (readonly, strong, nonatomic) NSArray* statements;

+ (id) objcBlockStatement;
- (void) addStatement:(FLObjcStatement*) statement;

@end

@interface FLObjcStringStatement : FLObjcStatement {
@private
    FLCodeChunk* _string;
}
+ (id) objcStringStatement;

@property (readonly, strong, nonatomic) FLCodeChunk* string;

@end

