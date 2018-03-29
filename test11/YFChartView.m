//
//  YFChartView.m
//  test11
//
//  Created by leoshi on 2018/3/29.
//  Copyright © 2018年 gongzi. All rights reserved.
//

#import "YFChartView.h"
#define blank   30  //边距

@implementation YFChartView{
    
    CGFloat             width;
    CGFloat             height;
    CGFloat             content_width;
    CGFloat             content_height;
    CGFloat             max_value;
    
}


- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:82/255.0 green:162/255.0 blue:255/255.0 alpha:1.0];
        [self beginDrawLine];
        _numArr = @[@"11",@"35",@"51",@"23",@"67",@"65",@"75",@"42",@"84",@"96"];
        width = CGRectGetWidth(frame);
        height = CGRectGetHeight(frame);
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)beginDrawLine{
    
    
    
    
}

- (void)drawBackgroundWithRect:(CGRect)rect{
    
    //画可用画布区域
    content_width = width-blank*2;
    content_height = height-blank*2;
    CGContextRef   context = UIGraphicsGetCurrentContext();
    CGFloat height = CGRectGetHeight(rect);
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextMoveToPoint(context, blank, 0);
    CGContextAddLineToPoint(context, blank, height-blank);
    CGContextAddLineToPoint(context, CGRectGetWidth(rect)-blank, height-blank);
    CGContextMoveToPoint(context, blank, height-blank);
    CGContextAddLineToPoint(context, 0, height);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextClosePath(context);
    
}

- (void)drawDish{
    //画坐标线
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetLineCap(context, kCGLineCapRound);//端点
    CGFloat lentghs[] = {5,5};
    CGContextSetLineDash(context, 5, lentghs, 2);//虚线
    CGFloat max = [[_numArr valueForKeyPath:@"@max.floatValue"] floatValue];
    max_value = ceil(max/10)*10;
    for (int i = 1 ; i < _numArr.count+1; i++) {

        CGFloat y_point = height-blank-(content_height/10)*i;
        CGContextMoveToPoint(context, blank, y_point);
        int tets = i*ceil(max/10);
        [[NSString stringWithFormat:@"%d",tets] drawAtPoint:CGPointMake(blank-5, y_point) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        CGContextSetStrokeColorWithColor(context, [UIColor lightTextColor].CGColor);
        CGContextAddLineToPoint(context, width-blank, y_point);
    }
    CGContextDrawPath(context, kCGPathStroke);
    CGContextClosePath(context);
    
}

//渐变柱形图
- (void)drawRectWithAnimate{
    
    CAShapeLayer *rectLayer = [CAShapeLayer layer];
    rectLayer.frame = self.bounds;
    rectLayer.strokeColor = [UIColor colorWithRed:222/255.0 green:79/255.0 blue:70/255.0 alpha:1.0].CGColor;
    rectLayer.fillColor = [UIColor clearColor].CGColor;
    rectLayer.lineWidth = content_width/10-15;
    rectLayer.lineCap = kCALineCapSquare;//kCALineCapRound 线的头部为圆
    rectLayer.lineJoin = kCALineJoinMiter;
    
    CAGradientLayer *gradLayer = [CAGradientLayer layer];
    gradLayer.frame = rectLayer.frame;
    gradLayer.colors = [NSMutableArray arrayWithArray:@[(__bridge id)[UIColor colorWithRed:253 / 255.0 green:164 / 255.0 blue:8 / 255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:251 / 255.0 green:37 / 255.0 blue:45 / 255.0 alpha:1.0].CGColor]];
    gradLayer.locations = @[@(0.3),@(0.5)];
    gradLayer.startPoint = CGPointMake(0, 1);
    gradLayer.endPoint = CGPointMake(1, 0);
    [gradLayer setMask:rectLayer];
    [self.layer addSublayer:gradLayer];
    
    UIBezierPath    *rectPath = [UIBezierPath bezierPath];
    for (int i = 0; i < _numArr.count; i++) {
        CGFloat x_point = blank+(content_width/10-2)*(i+1);
        NSInteger num = [[_numArr objectAtIndex:i] intValue];
        CGFloat y_real = height-blank-(num*(content_height/max_value));
        [[NSString stringWithFormat:@"%ld",(long)num] drawAtPoint:CGPointMake(x_point-10, y_real-35) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
        [rectPath moveToPoint:CGPointMake(x_point, height-blank)];
        [rectPath addLineToPoint:CGPointMake(x_point, y_real)];
    }
    rectLayer.path = rectPath.CGPath;
    
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animate.fromValue = @(0.0);
    animate.toValue = @(1.0);
    animate.duration = 3.0;
    animate.autoreverses = NO;
    [rectLayer addAnimation:animate forKey:@"strokeEnd"];
    
    
}
//渐变折线图
- (void)drawLineWithAnimate{
    
    CAShapeLayer *lineLayer = [[CAShapeLayer alloc]init];
    lineLayer.frame = self.bounds;
    lineLayer.strokeColor = [UIColor colorWithRed:222/255.0 green:79/255.0 blue:70/255.0 alpha:1.0].CGColor;
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.lineWidth = 2.5;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.lineJoin = kCALineJoinRound;
    //渐变遮罩
    CAGradientLayer *gradLayer = [CAGradientLayer layer];
    gradLayer.frame = lineLayer.frame;
    gradLayer.colors = [NSMutableArray arrayWithArray:@[(__bridge id)[UIColor colorWithRed:153 / 255.0 green:134 / 255.0 blue:8 / 255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:51 / 255.0 green:37 / 255.0 blue:45 / 255.0 alpha:1.0].CGColor]];
    gradLayer.locations = @[@(0.3),@(0.5)];
    
    gradLayer.startPoint = CGPointMake(0, 1);
    gradLayer.endPoint = CGPointMake(1, 0);
    
    [gradLayer setMask:lineLayer];
    
    [self.layer addSublayer:gradLayer];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    for (int i = 0; i < _numArr.count; i++) {
        CGFloat x_point = blank+(content_width/10-2)*(i+1);
        NSInteger num = [[_numArr objectAtIndex:i] intValue];
        CGFloat y_real = height-blank-(num*(content_height/max_value));
//        [[NSString stringWithFormat:@"%ld",(long)num] drawAtPoint:CGPointMake(x_point-8, y_real-8) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        if (i == 0) {
            [linePath moveToPoint:CGPointMake(x_point, y_real)];
        }
        else{
            [linePath addLineToPoint:CGPointMake(x_point, y_real)];
        }
    }
    lineLayer.path = linePath.CGPath;
    
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animate.fromValue = @(0.0);
    animate.toValue = @(1.0);
    animate.duration = 5.0;
    animate.autoreverses = NO;
    [lineLayer addAnimation:animate forKey:@"strokeEnd"];
    
}


- (void)drawRect:(CGRect)rect{
    
    [self drawBackgroundWithRect:rect];
    [self drawDish];
    [self drawLineWithAnimate];
    [self drawRectWithAnimate];
   
}

@end
