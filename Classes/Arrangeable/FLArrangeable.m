
#import "FLArrangeable.h"

static const FLArrangeableState FLArrangeableStateZero = { {0,0,0,0}, 0, 0, {{0,0},{0,0}}, {0,0,0,0} };

@implementation FLArrangeableObject

@synthesize frame = _frame;
@synthesize hidden = _hidden;
@synthesize arrangeableState = _arrangeableState;

FLSynthesizeStructProperty(arrangeableInsets, setArrangeableInsets, FLEdgeInsets, _arrangeableState);
FLSynthesizeStructProperty(arrangeableFillMode, setArrangeableFillMode, FLArrangeableFillMode, _arrangeableState);
FLSynthesizeStructProperty(arrangeableWeight, setArrangeableWeight, FLArrangeableWeight, _arrangeableState);

- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}

- (id) initWithFrame:(FLRect) frame {
    self = [self init];
    if(self) {
        self.frame = frame;
    }
    
    return self;
}

+ (FLArrangeableObject*) arrangeableObject {
    return FLReturnAutoreleased([[[self class] alloc] init]);   
}


+ (FLArrangeableObject*) arrangeableObject:(CGRect) frame {
    return FLReturnAutoreleased([[[self class] alloc] initWithFrame:frame]);
}

+ (id) lastSubframeByWeight:(FLArrangeableWeight) weight
                  subframes:(NSArray*) subframes {
    id last = nil;
    for(id frame in subframes) {
        FLArrangeableWeight arrangeableWeight = [frame arrangeableWeight];
        if(arrangeableWeight > weight) {
            break;
        }
        
        last = frame;
    }
    
    return last;
}


- (void) calculateArrangementSize:(CGSize*) outSize
                           inSize:(CGSize) inSize
                         fillMode:(FLArrangeableFillMode) fillMode {
}

@end


