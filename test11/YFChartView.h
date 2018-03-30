//
//  YFChartView.h
//  test11
//  柱形图
//  Created by leoshi on 2018/3/29.
//  Copyright © 2018年 gongzi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    pathTypeLine,
    pathTypeRect,
    pathTypeCircle,
} pathType;

@interface YFChartView : UIView




/**
 测试标注
 */
@property (nonatomic, copy)     NSString *testStr;

/**
 画折线图的数组
 */
@property (nonatomic, retain)           NSArray     *numArr;

/**
 画图的类型
 */
@property (nonatomic, assign)       pathType chartType;

/**
 测试方法标注
 */
//- (void)testFuncName:(NSInteger)num;
@end
