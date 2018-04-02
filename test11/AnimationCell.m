//
//  AnimationCell.m
//  test11
//
//  Created by leoshi on 2018/4/2.
//  Copyright © 2018年 gongzi. All rights reserved.
//

#import "AnimationCell.h"

@implementation AnimationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.animaBlock = ^(NSInteger index) {
        switch (index) {
            case 0:
            {
                [self.animaView addCABasicAnimationWithKey:self.titlelable.text withDuration:2.0 withFrom:[NSValue valueWithCGPoint:CGPointMake(0, 90)] withTo:[NSValue valueWithCGPoint:CGPointMake(350, 90)]];
            }
                break;
            case 1:
            {
                [self.animaView addCABasicAnimationWithKey:self.titlelable.text withDuration:2.0 withFrom:[NSValue valueWithCGRect:CGRectMake(0, 0, 0, 0)] withTo:[NSValue valueWithCGRect:CGRectMake(0, 0, Screen_Width, CGRectGetHeight(self.frame)-30)]];
            }
                break;
            case 2:
            {
                //3D缩放
                //                [self.animaView addCABasicAnimationWithKey:self.titlelable.text withDuration:2.0 withFrom:[NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1, 1, 0)] withTo:[NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.3, 1)]];
                //3D平移
                //                [self.animaView addCABasicAnimationWithKey:self.titlelable.text withDuration:2.0 withFrom:[NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DIdentity, 20, 0, 0)] withTo:[NSValue valueWithCATransform3D:CATransform3DTranslate(CATransform3DIdentity, 120, 0, 0)]];
                //3D旋转
                [self.animaView addCABasicAnimationWithKey:self.titlelable.text withDuration:2.0 withFrom:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 0)] withTo:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.5, 1, 1)]];
            }
                break;
            case 3:
            {
                //背景色
                [self.animaView addCABasicAnimationWithKey:self.titlelable.text withDuration:2.0 withFrom:(id)[UIColor redColor].CGColor withTo:[UIColor blueColor].CGColor];
            }
                break;
            case 4:
            {
                //透明度
                [self.animaView addCABasicAnimationWithKey:self.titlelable.text withDuration:4.0 withFrom:@(0.1) withTo:@(0.9)];
            }
                break;
            case 5:
            {
                //渐变圆角
                [self.animaView addCABasicAnimationWithKey:self.titlelable.text withDuration:3.0 withFrom:@(3) withTo:@(50)];
            }
                break;
            default:
                break;
        }
    };
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
