//
//  UIImageView+Fileter.h
//  test11
//
//  Created by leoshi on 2018/2/7.
//  Copyright © 2018年 gongzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Fileter)



//string            需要显示为二维码的文字
//imageSize         图片大小
//isOwnLogo         是否有Logo
//logoSize          Logo的大小

- (void)SetImageForString:(NSString *)string imageSize:(CGFloat)imageSize withLogo:(BOOL)isOwnLogo withLogoSize:(CGFloat)logoSize;

@end
