//
//  FLObjectXmlElement.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLObjectXmlElement.h"
#import "FLXmlDocumentBuilder.h"

@interface FLObjectXmlElement ()
@property (readwrite, strong, nonatomic) id object;
@property (readwrite, strong, nonatomic) FLPropertyType* propertyType;
@end

@implementation FLObjectXmlElement

@synthesize object = _object;
@synthesize propertyType = _propertyType;

- (id) initWithObject:(id) object xmlElementTag:(NSString*) xmlElementTag xmlElementCloseTag:(NSString*) xmlElementCloseTag {
    self = [super initWithXmlElementTag:xmlElementTag xmlElementCloseTag:xmlElementCloseTag];
    if(self) {
        self.object = object;
    }
    return self;
}

- (id) initWithObject:(id) object xmlElementTag:(NSString*) xmlElementTag {
    return [self initWithObject:object xmlElementTag:xmlElementTag xmlElementCloseTag:xmlElementTag];
}

+ (id) objectXmlElement:(id) object xmlElementTag:(NSString*) xmlElementTag {
    return FLAutorelease([[[self class] alloc] initWithObject:object xmlElementTag:xmlElementTag]);
}

+ (id) objectXmlElement:(id) object xmlElementTag:(NSString*) xmlElementTag xmlElementCloseTag:(NSString*) xmlElementCloseTag {
    return FLAutorelease([[[self class] alloc] initWithObject:object xmlElementTag:xmlElementTag]);
}

- (id) initWithObject:(id) object
          xmlElementTag:(NSString*) xmlElementTag
          propertyType:(FLPropertyType*) description {
    
    self = [self initWithObject:object xmlElementTag:xmlElementTag];
    if(self) {
        self.propertyType = description;
    }
            
    return self;
}          

+ (id) objectXmlElement:(id) object 
          xmlElementTag:(NSString*) xmlElementTag
          propertyType:(FLPropertyType*) description {
    return FLAutorelease([[[self class] alloc] initWithObject:object xmlElementTag:xmlElementTag propertyType:description]);
}          


#if FL_MRC
- (void) dealloc {
    [_object release];
    [_propertyType release];
    [super dealloc];
}
#endif

//- (void) appendLineWithEncodedObject:(id) object
//                   propertyType:(FLPropertyType*) description {
//
//    if(object) {
//        FLAssertNotNil_v(description, @"serialization requires property description");
//        
//        id<FLDataEncoding> dataEncoder = [self dataEncoder];
//        FLConfirmNotNil_v(dataEncoder, @"Xml String builder requires a data encoder");
//    
//		NSString* string = [dataEncoder encodeDataToString:object forType:description.propertyType];
//        FLAssertNotNil_(string);
//        FLConfirm_([string isKindOfClass:[NSString class]]);
//        [self appendLine:string];
//	}
//}

- (void) didMoveToParent:(id) parent {

    [super didMoveToParent:parent];
    if(parent && _object) {
        
        if(!self.dataEncoder) {
            id walker = self.parent;
            while(walker) {
                if([walker respondsToSelector:@selector(dataEncoder)]) {
                    id dataEncoder = [walker dataEncoder];
                    if(dataEncoder) {
                        self.dataEncoder = dataEncoder;
                        break;
                    }

                }
                walker = [walker parent];
            }
        }
    
        FLAssertNotNil_([self dataEncoder]);
        
        [_object addToXmlElement:self propertyType:_propertyType];
    }
}

@end

/*
@interface FLXmlElementStringBuilderLine : FLStringBuilderLine {
@private
    id _object;
    FLPropertyType* _propertyType;
    NSString* _encodedString;
}

+ (id) xmlElementStringBuilderLine:(id) object propertyType:(FLPropertyType*) description;

@end

@interface FLXmlElementStringBuilderLine ()
@property (readwrite, strong, nonatomic) id object;
@property (readwrite, assign, nonatomic) FLPropertyType* propertyType;
@property (readwrite, strong, nonatomic) NSString* encodedString;

@end

@implementation FLXmlElementStringBuilderLine

@synthesize object = _object;
@synthesize propertyType = _propertyType;
@synthesize encodedString = _encodedString;

+ (id) xmlElementStringBuilderLine:(id) object propertyType:(FLPropertyType*) description {

    FLAssertNotNil_(object);
    FLAssertNotNil_v(description, @"serialization as token requires property description")

    FLXmlElementStringBuilderLine* token = FLAutorelease([[[self class] alloc] init]);
    token.object = object;
    token.propertyType = description;
    return token;
}

#if FL_MRC
- (void) dealloc {
    [_encodedString release];
    [_object release];
    [_propertyType release];
    [super dealloc];
}
#endif

- (void) didMoveToParent:(id)parent {
            
    if(parent && _object) {
        FLAssertNotNil_v(_propertyType, @"serialization requires property description")
             
        id<FLDataEncoding> dataEncoder = [[parent document] dataEncoder];
        FLConfirmNotNil_v(dataEncoder, @"Xml String builder requires a data encoder");
    
        NSString* encodedString = nil;
        [dataEncoder encodeDataToString:_object forType:_propertyType.propertyType outEncodedString:&encodedString];
        FLAssertNotNil_(encodedString);
        FLConfirm_([encodedString isKindOfClass:[NSString class]]);
        
        self.string = encodedString;
    }
}

- (void) buildStringWithPrettyString:(FLPrettyString *) prettyString {
    if(FLStringIsNotEmpty(_encodedString)) {
        [prettyString appendString:_encodedString];
    }
}               

- (id) copyWithZone:(NSZone *)zone  {
    FLXmlElementStringBuilderLine* token = [[FLXmlElementStringBuilderLine alloc] init];
    token.object = self.object;
    token.propertyType = self.propertyType;
    token.string = self.string;
//    token.tabIndent = self.tabIndent;
    return token;
}

@end                  
*/