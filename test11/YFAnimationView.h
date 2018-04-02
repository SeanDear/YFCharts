//
//  YFAnimationView.h
//  test11
//
//  Created by leoshi on 2018/4/2.
//  Copyright © 2018年 gongzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFAnimationView : UIView








/**
 添加CABasicAnimation
 */
- (void)addCABasicAnimationWithKey:(NSString *)keyPath withDuration:(CGFloat)duration withFrom:(id)fromValue withTo:(id)toValue;
@end
