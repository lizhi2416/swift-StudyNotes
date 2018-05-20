//
//  NSObject+Caculator.h
//  测试UIFrame
//
//  Created by 蒋礼智 on 2018/5/19.
//  Copyright © 2018年 蒋礼智. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaculatorMaker.h"


//定义block从 “返回值”+（^xxx）+(type object)

//执行block ^+返回值+(type object)

@interface NSObject (Caculator)

+ (int)makeCaculators:(void(^)(CaculatorMaker *maker))block;

@end
