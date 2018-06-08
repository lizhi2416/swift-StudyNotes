//
//  NSObject+Caculator.m
//  测试UIFrame
//
//  Created by 蒋礼智 on 2018/5/19.
//  Copyright © 2018年 蒋礼智. All rights reserved.
//

#import "NSObject+Caculator.h"

@implementation NSObject (Caculator)

+ (int)makeCaculators:(void(^)(CaculatorMaker *maker))block {
    CaculatorMaker *maker = [[CaculatorMaker alloc] init];
    if (block) {
        block(maker);
    }
    return maker.result;
}

@end
