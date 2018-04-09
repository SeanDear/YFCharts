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
//画饼图
- (void)drawCircleWithAnimate{
    
    NSArray *numArr = @[@"1",@"2",@"3",@"4",@"5"];
    
    CGPoint circlePoint = CGPointMake(width/2, height/2);
    CGFloat radius = content_width < content_height ? content_width/2:content_height/2;
    CGFloat start = 0.0;
    CGFloat end = 0.0;
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:circlePoint radius:radius/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer *bglayer = [CAShapeLayer layer];
    bglayer.strokeStart = 0.0;
    bglayer.strokeEnd = 1.0;
    bglayer.lineWidth = radius;
    bglayer.strokeColor = [UIColor colorWithRed:arc4random()*59%255/255.0 green:arc4random()*139%255/255.0 blue:arc4random()*208%255/255.0 alpha:1.0].CGColor;
    bglayer.fillColor = [UIColor clearColor].CGColor;
    bglayer.path = circlePath.CGPath;
    bglayer.zPosition = 1;
//    [self.layer addSublayer:bglayer];
    for (int i = 0; i <numArr.count; i++) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        int num = [[numArr objectAtIndex:i] intValue];
        end = start+num/15.0;
        layer.strokeStart = start;
        layer.strokeEnd = end;
        layer.lineWidth = radius;
        layer.zPosition = 2;
        layer.strokeColor = [UIColor colorWithRed:arc4random()*59%255/255.0 green:arc4random()*139%255/255.0 blue:arc4random()*208%255/255.0 alpha:1.0].CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.path = circlePath.CGPath;
        [self.layer addSublayer:layer];
        CGPoint strPoint = [self pointWithAngle:(start +num/15.0/2)*M_PI*2 withRadius:radius withCenter:circlePoint withClockwise:YES];
        UILabel *dtrLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        dtrLabel.text = [NSString stringWithFormat:@"%.2f%%",num/15.0*100];
        dtrLabel.center = strPoint;
        dtrLabel.textColor = [UIColor whiteColor];
        dtrLabel.font = [UIFont systemFontOfSize:10];
        dtrLabel.layer.zPosition = 3;
        //        dtrLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:dtrLabel];

        start = end;

    }
    self.layer.mask = bglayer;
    CABasicAnimation *animate = [self animationWithduration:2.0 withFrom:@(0.0) withTo:@(1.0)];
    [bglayer addAnimation:animate forKey:@"circleEnd"];
}

- (void)drawCircleString{
    
    NSArray *numArr = @[@"1",@"2",@"3",@"4",@"5"];
    CGFloat radius = content_width < content_height ? content_width/2:content_height/2;
    CGPoint circlePoint = CGPointMake(width/2, height/2);
    // 用于计算偏移角度对应的x,y坐标。
    CGFloat start = 0.0;
    CGFloat end = 0.0;
    for (int i = 0; i <numArr.count; i++) {
        int num = [[numArr objectAtIndex:i] intValue];
        end = start+num/15.0;
        
//        [@"所占比例" drawAtPoint:strPoint withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blackColor]}];
        start = end;
    }
}

//根据圆心坐标、半径以及角度计算偏移量坐标
- (CGPoint )pointWithAngle:(CGFloat)angle withRadius:(CGFloat)radius withCenter:(CGPoint )center withClockwise:(BOOL)wise{
    
    
    CGFloat r = radius/2.0;//标注的半径
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    if (wise) {
        //顺时针
        if (angle > 0 && angle < 90) {
            //第四象限
            x = center.x + cos(angle)*r;
            y = center.y + sin(angle)*r;
        }
        else if (angle > 90 && angle < 180){
            //第三象限
            angle = M_PI - angle;
            x = center.x - cos(angle)*r;
            y = center.y + sin(angle)*r;
        }
        else if (angle > 180 && angle < 270){
            //第二象限
            angle = angle - M_PI;
            x = center.x - cos(angle)*r;
            y = center.y - sin(angle)*r;
        }
        else if (angle > 270 && angle < 360){
            //第一象限
            angle = M_PI*2 - angle;
            x = center.x + cos(angle)*r;
            y = center.y - sin(angle)*r;
        }
    }
    else{
        
        //逆时针
        if (angle > 0 && angle < 90) {
            //第一象限
            x = center.x + cos(angle)*r;
            y = center.y - sin(angle)*r;
        }
        else if (angle > 90 && angle < 180){
            //第二象限
            angle = M_PI - angle;
            x = center.x - cos(angle)*r;
            y = center.y - sin(angle)*r;
        }
        else if (angle > 180 && angle < 270){
            //第三象限
            angle = angle - M_PI;
            x = center.x - cos(angle)*r;
            y = center.y + sin(angle)*r;
        }
        else if (angle > 270 && angle < 360){
            //第四象限
            angle = M_PI*2 - angle;
            x = center.x + cos(angle)*r;
            y = center.y + sin(angle)*r;
        }
    }
    return CGPointMake(x, y);
}

//创建绘图图层
- (CAShapeLayer *)CALayerWithStroke:(UIColor *)strokeColor withFillColor:(UIColor *)fillColor withLineWidth:(CGFloat)lineWidth{
    
    CAShapeLayer *Layer = [CAShapeLayer layer];
    Layer.frame = self.bounds;
    Layer.strokeColor = strokeColor.CGColor;
    Layer.fillColor = fillColor.CGColor;
    Layer.lineWidth = lineWidth;
    Layer.lineCap = kCALineCapSquare;//kCALineCapRound 线的头部为圆
    Layer.lineJoin = kCALineJoinMiter;
    
    return Layer;
}
//创建渐变遮罩
- (CAGradientLayer *)CAGraientLayerWithcolors:(NSArray *)colors withLocations:(NSArray *)locations withStartPoint:(CGPoint)start withEndPoint:(CGPoint)end{
    
    CAGradientLayer *gradLayer = [CAGradientLayer layer];
    gradLayer.frame = self.bounds;
    gradLayer.colors = colors;
    gradLayer.locations = locations;
    gradLayer.startPoint = start;
    gradLayer.endPoint = end;
    return gradLayer;
}
//创建动画
- (CABasicAnimation *)animationWithduration:(CGFloat)duration withFrom:(id)formValue withTo:(id)toValue{
    
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animate.fromValue = formValue;
    animate.toValue = toValue;
    animate.duration = duration;
    animate.autoreverses = NO;
    return animate;
}

//渐变柱形图
- (void)drawRectWithAnimate{
    
    CAShapeLayer *rectLayer = [self CALayerWithStroke:[UIColor colorWithRed:222/255.0 green:79/255.0 blue:70/255.0 alpha:1.0] withFillColor:[UIColor clearColor] withLineWidth:(content_width/10-15)];
    
    CAGradientLayer *gradLayer = [self CAGraientLayerWithcolors:[NSMutableArray arrayWithArray:@[(__bridge id)[UIColor colorWithRed:253 / 255.0 green:164 / 255.0 blue:8 / 255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:251 / 255.0 green:37 / 255.0 blue:45 / 255.0 alpha:1.0].CGColor]] withLocations:@[@(0.3),@(0.5)] withStartPoint:CGPointMake(0, 1) withEndPoint:CGPointMake(1, 0)];
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
    
    CABasicAnimation *animate = [self animationWithduration:3.0 withFrom:@(0.0) withTo:@(1.0)];
    [rectLayer addAnimation:animate forKey:@"strokeEnd"];
    
    
}
//渐变折线图
- (void)drawLineWithAnimate{
    
    CAShapeLayer *lineLayer = [self CALayerWithStroke:[UIColor colorWithRed:222/255.0 green:79/255.0 blue:70/255.0 alpha:1.0] withFillColor:[UIColor clearColor] withLineWidth:2.5];
    
    //渐变遮罩
    CAGradientLayer *gradLayer = [self CAGraientLayerWithcolors:[NSMutableArray arrayWithArray:@[(__bridge id)[UIColor colorWithRed:153 / 255.0 green:134 / 255.0 blue:8 / 255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:51 / 255.0 green:37 / 255.0 blue:45 / 255.0 alpha:1.0].CGColor]] withLocations:@[@(0.3),@(0.5)] withStartPoint:CGPointMake(0, 1) withEndPoint:CGPointMake(1, 0)];
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
    
    CABasicAnimation *animate = [self animationWithduration:5.0 withFrom:@(0.0) withTo:@(1.0)];
    [lineLayer addAnimation:animate forKey:@"strokeEnd"];
    
}


- (void)drawRect:(CGRect)rect{
    
    [self drawBackgroundWithRect:rect];
    switch (_chartType) {
        case pathTypeLine:
        {
            [self drawDish];
            [self drawLineWithAnimate];
        }
            break;
        case pathTypeRect:
        {
            [self drawDish];
            [self drawLineWithAnimate];
            [self drawRectWithAnimate];
        }
            break;
        case pathTypeCircle:
        {
            [self drawCircleWithAnimate];
            [self drawCircleString];
        }
            break;
        default:
            break;
    }
    
    
    
   
}

@end
