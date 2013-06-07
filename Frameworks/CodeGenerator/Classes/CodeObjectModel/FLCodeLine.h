//
//  FLCodeLine.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLModelObject.h"

typedef enum {
  FLCodeLineTypeReturnSelf,
  FLCodeLineTypeReturnIvar,
  FLCodeLineTypeReturnNewObject,
  FLCodeLineTypeReturnString,
  FLCodeLineTypeDefaultCtor,
} FLCodeLineType;

#define FLCodeLineClassName @"ClassName"
#define FLCodeLineString @"String"

@interface FLCodeLine : FLModelObject {
@private
    FLCodeLineType _codeLineType;
    NSMutableDictionary* _parameters;
}
+ (id) codeLine:(FLCodeLineType) codeLineType;
@property (readonly, strong, nonatomic) NSDictionary* parameters;
@property (readwrite, assign, nonatomic) FLCodeLineType codeLineType;

- (void) addParameter:(id) param forKey:(id) key;
- (id) parameterForKey:(id) key;

+ (id) codeLineReturnString:(NSString*) string;
+ (id) codeLineReturnNewObject:(NSString*) objectClass;

@end
