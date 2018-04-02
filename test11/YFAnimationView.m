//
//  YFAnimationView.m
//  test11
//
//  Created by leoshi on 2018/4/2.
//  Copyright © 2018年 gongzi. All rights reserved.
//

#import "YFAnimationView.h"

@implementation YFAnimationView



- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
    }
    return self;
}

- (void)addCABasicAnimationWithKey:(NSString *)keyPath withDuration:(CGFloat)duration withFrom:(id)fromValue withTo:(id)toValue {
    //position bounds
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.duration = duration;
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.repeatCount = MAXFLOAT;
    [self.layer addAnimation:animation forKey:@"YFPosition"];
}


- (void)addAnimateGroup{
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
