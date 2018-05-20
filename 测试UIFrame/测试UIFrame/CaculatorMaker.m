//
//  CaculatorMaker.m
//  测试UIFrame
//
//  Created by 蒋礼智 on 2018/5/19.
//  Copyright © 2018年 蒋礼智. All rights reserved.
//

#import "CaculatorMaker.h"

@implementation CaculatorMaker

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (CasulatorBlock)add {
    CasulatorBlock block = ^CaculatorMaker *(int num) {
        self.result += num;
        return self;
    };
    return block;
}

- (CasulatorBlock)sub {
    return ^CaculatorMaker *(int num) {
        self.result -= num;
        return self;
    };
}

- (CasulatorBlock)muilt {
    return ^CaculatorMaker *(int num) {
        self.result *= num;
        return self;
    };
}

- (CasulatorBlock)divide {
    return ^CaculatorMaker *(int num) {
        self.result /= num;
        return self;
    };
}

@end
