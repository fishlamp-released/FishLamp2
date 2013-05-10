//
//  FLCoreTypes.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCoreTypes.h"
#import "FLObjectEncoder.h"

//// objects
//enum  {
//    FLTypeIDObject              = _C_CLASS,
//    FLTypeIDAbstractObject      = _C_ID,
//    FLTypeIDString              = 'stro',
//    FLTypeIDDate                = 'date',
//    FLTypeIDURL                 = 'urlo',
//    FLTypeIDData                = 'data'
//};     
//
//// geometry 
//enum {
//	FLTypeIDPoint               = 'poin',
//	FLTypeIDRect                = 'rect',
//	FLTypeIDSize                = 'size',
//};
//
//
//@implementation FLNumberEncoder 
//
//@synthesize numberType = _numberType;
//
//- (id) initWithEncodingKey:(NSString*) key numberType:(FLTypeNumberType) numberType {
//    self = [self initWithEncodingKey:key];
//    if(self) {
//        _numberType = numberType;
//    }
//    return self;
//}
//
//
//@end
//
//@implementation FLNumberObject
//
//
//@end
//
//@implementation FLBoolNumber 
//
//+ (id) boolNumber {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLNumberEncoder alloc] initWithEncodingKey:@"BOOL" numberType:FLTypeIDBool]));
//}
//
//@end
//
//@implementation FLCharNumber 
//
//+ (id) charNumber {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLNumberEncoder alloc] initWithEncodingKey:@"Number" numberType:FLTypeIDChar]));
//}
//
//
//@end
//
//@implementation FLUnsignedCharNumber 
//
//
//+ (id) unsignedCharNumber {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLNumberEncoder alloc] initWithEncodingKey:@"Number" numberType:FLTypeIDUnsignedChar]));
//}
//
//
//@end
//
//@implementation FLShortNumber 
//
//+ (id) shortNumber {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLNumberEncoder alloc] initWithEncodingKey:@"Number" numberType:FLTypeIDShort]));
//}
//
//@end
//
//@implementation FLUnsignedShortNumber 
//
//+ (id) unsignedShortNumber {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLNumberEncoder alloc] initWithEncodingKey:@"Number" numberType:FLTypeIDUnsignedShort]));
//}
//
//
//@end
//
//@implementation FLIntNumber 
//
//+ (id) intNumber {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLNumberEncoder alloc] initWithEncodingKey:@"Number" numberType:FLTypeIDInt]));
//}
//
//
//@end
//
//@implementation FLUnsignedIntNumber 
//
//+ (id) unsignedIntNumber {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLNumberEncoder alloc] initWithEncodingKey:@"Number" numberType:FLTypeIDUnsignedInt]));
//}
//
//
//
//@end
//
//@implementation FLLongNumber 
//
//+ (id) longNumber {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLNumberEncoder alloc] initWithEncodingKey:@"Number" numberType:FLTypeIDLong]));
//}
//
//
//@end
//
//@implementation FLUnsignedLongNumber 
//
//
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLNumberEncoder alloc] initWithEncodingKey:@"Number" numberType:FLTypeIDUnsignedLong]));
//}
//
//+ (id) unsignedLongNumber {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//
//@end
//
//@implementation FLLongLongNumber 
//
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLNumberEncoder alloc] initWithEncodingKey:@"Number" numberType:FLTypeIDLongLong]));
//}
//
//+ (id) longLongNumber {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//
//@end
//
//@implementation FLUnsignedLongLongNumber 
//
//+ (id) unsignedLongLongNumber {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLNumberEncoder alloc] initWithEncodingKey:@"Number" numberType:FLTypeIDUnsignedLongLong]));
//}
//
//
//@end
//
//@implementation FLFloatNumber 
//
//+ (id) floatNumber {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLNumberEncoder alloc] initWithEncodingKey:@"Number" numberType:FLTypeIDFloat]));
//}
//@end
//
//@implementation FLDoubleNumber 
//
//+ (id) doubleNumber {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLNumberEncoder alloc] initWithEncodingKey:@"Number" numberType:FLTypeIDDouble]));
//}
//
//@end
//
//@implementation FLIntegerNumber 
//
//+ (id) integerNumber {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLNumberEncoder alloc] initWithEncodingKey:@"Number" numberType:FLTypeIDLong]));
//}
//
//@end
//
//@implementation FLUnsignedIntegerNumber 
//
//+ (id) unsignedIntegerNumber {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLNumberEncoder alloc] initWithEncodingKey:@"Number" numberType:FLTypeIDUnsignedLong]));
//}
//
//
//@end
//
//@implementation FLValueEncoder 
//@end
//
//@implementation FLGeometrySize 
//+ (id) geometrySize {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLValueEncoder alloc] initWithEncodingKey:@"Size"]));
//}
//
//@end
//
//@implementation FLGeometryRect 
//
//+ (id) geometryRect {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLValueEncoder alloc] initWithEncodingKey:@"Rect"]));
//}
//
//@end
//
//@implementation FLGeometryPoint 
//
//+ (id) geometryPoint {
//    FLReturnStaticObject(FLAutorelease([[[self class] alloc] init]));  
//}
//
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject(FLAutorelease([[FLValueEncoder alloc] initWithEncodingKey:@"Point"]));
//}
//
//@end

@implementation NSString (FLCoreTypes)
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[FLObjectEncoder alloc] initWithEncodingKey:@"String"]);
}

@end

@implementation NSArray (FLCoreTypes)
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[FLObjectEncoder alloc] initWithEncodingKey:@"Array"]);
}
@end

//@implementation NSMutableArray (FLCoreTypes)
//+ (FLObjectEncoder*) objectEncoder {
//    FLReturnStaticObject([[FLMutableArrayType alloc] initWithEncodingKey:@"MutableArray"]);
//}
//@end

@implementation NSURL (FLCoreTypes)
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[FLObjectEncoder alloc] initWithEncodingKey:@"URL" ]);
}
@end

@implementation NSData (FLCoreTypes)
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[FLObjectEncoder alloc] initWithEncodingKey:@"Data" ]);
}
@end

@implementation NSDate (FLCoreTypes)
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[FLObjectEncoder alloc] initWithEncodingKey:@"Date" ]);
}
@end

@implementation SDKFont (FLCoreTypes)
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[FLObjectEncoder alloc] initWithEncodingKey:@"Font"]);
}
@end

@implementation SDKColor (FLCoreTypes)
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject([[FLObjectEncoder alloc] initWithEncodingKey:@"Color"]);
}
@end

@implementation NSNumber (FLCoreTypes) 
+ (FLObjectEncoder*) objectEncoder {
    FLReturnStaticObject(FLAutorelease([[FLObjectEncoder alloc] initWithEncodingKey:@"Number"]));
}
@end



