//
//  ViewController.m
//  iOS 生成图片验证码
//
//  Created by tianXin on 16/3/18.
//  Copyright © 2016年 tianXin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic ,strong) UILabel *imageAuthenticationLabel;
@property (nonatomic ,copy)   NSString *code;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageAuthenticationLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 70, 30)];
    _imageAuthenticationLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapToGenerateCode:)];
    [_imageAuthenticationLabel addGestureRecognizer:tap];
    [self.view addSubview:self.imageAuthenticationLabel];

    [self onTapToGenerateCode:nil];
}


- (void)onTapToGenerateCode:(UITapGestureRecognizer *)tap {
    for (UIView *view in self.imageAuthenticationLabel.subviews) {
        [view removeFromSuperview];
    }
    // @{
    // @name 生成背景色
    float red = arc4random() % 100 / 100.0;
    float green = arc4random() % 100 / 100.0;
    float blue = arc4random() % 100 / 100.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:0.2];
    [self.imageAuthenticationLabel setBackgroundColor:color];
    // @} end 生成背景色
    
    // @{
    // @name 生成文字
    const int count = 5;
    char data[count];
    for (int x = 0; x < count; x++) {
        int j = '0' + (arc4random_uniform(75));
        if((j >= 58 && j <= 64) || (j >= 91 && j <= 96)||(j < 48 && j > 57)){
            --x;
        }else{
            data[x] = (char)j;
        }
    }
    NSString *text = [[NSString alloc] initWithBytes:data
                                              length:count encoding:NSUTF8StringEncoding];
    self.code = text;
    // @} end 生成文字
    
    CGSize cSize = [@"S" sizeWithFont:[UIFont systemFontOfSize:16]];
    int width = self.imageAuthenticationLabel.frame.size.width / text.length - cSize.width;
    int height = self.imageAuthenticationLabel.frame.size.height - cSize.height;
    CGPoint point;
    float pX, pY;
    for (int i = 0, count = text.length; i < count; i++) {
        pX = arc4random() % width + self.imageAuthenticationLabel.frame.size.width / text.length * i - 1;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [text characterAtIndex:i];
        UILabel *tempLabel = [[UILabel alloc]
                              initWithFrame:CGRectMake(pX, pY,
                                                       self.imageAuthenticationLabel.frame.size.width / 4,
                                                       self.imageAuthenticationLabel.frame.size.height)];
        tempLabel.backgroundColor = [UIColor clearColor];
        
        // 字体颜色
        float red = arc4random() % 100 / 100.0;
        float green = arc4random() % 100 / 100.0;
        float blue = arc4random() % 100 / 100.0;
        UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        tempLabel.textColor = color;
        tempLabel.text = textC;
        [self.imageAuthenticationLabel addSubview:tempLabel];
    }
    
    // 干扰线
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    for(int i = 0; i < count; i++) {
        red = arc4random() % 100 / 100.0;
        green = arc4random() % 100 / 100.0;
        blue = arc4random() % 100 / 100.0;
        color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        pX = arc4random() % (int)self.imageAuthenticationLabel.frame.size.width;
        pY = arc4random() % (int)self.imageAuthenticationLabel.frame.size.height;
        CGContextMoveToPoint(context, pX, pY);
        pX = arc4random() % (int)self.imageAuthenticationLabel.frame.size.width;
        pY = arc4random() % (int)self.imageAuthenticationLabel.frame.size.height;
        CGContextAddLineToPoint(context, pX, pY);  
        CGContextStrokePath(context);  
    }  
    return;  
}

@end
