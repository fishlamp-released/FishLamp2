//
//	GtCodeGeneratorTypeDefinition+More.h
//	PackMule
//
//	Created by Mike Fullerton on 12/19/10.
//	Copyright 2010 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtCodeGeneratorEnums.h"
#import "GtCodeGeneratorTypeDefinition.h"

@interface GtCodeGeneratorTypeDefinition (More)

@property (readonly, nonatomic, assign) BOOL dataTypeIsEnum;
@property (readonly, nonatomic, assign) BOOL dataTypeIsObject;
@property (readonly, nonatomic, assign) BOOL dataTypeIsValue;



@end
