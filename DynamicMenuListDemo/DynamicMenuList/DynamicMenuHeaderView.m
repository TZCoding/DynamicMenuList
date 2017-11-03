//
//  DynamicMenuHeaderView.m
//  MADPMainRootMenu
//
//  Created by TZ on 2017/8/29.
//  Copyright © 2017年 TZ. All rights reserved.
//

#import "DynamicMenuHeaderView.h"

@implementation DynamicMenuHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.headLabel];
    }
    return self;
}

- (UILabel *)headLabel {
    if (!_headLabel) {
        _headLabel = [UILabel new];
        _headLabel.font = [UIFont systemFontOfSize:16];
        _headLabel.frame = CGRectMake(15, 10, 80, 20);
        
        CALayer *topLine = [CALayer layer];
        topLine.frame = CGRectMake(0, 0, kScreen_Width, kSeparatorLineHeight);
        topLine.backgroundColor = kSeparatorLineColor.CGColor;
        [self.layer addSublayer:topLine];
        
        CALayer *bottomLine = [CALayer layer];
        bottomLine.frame = CGRectMake(0, 40 - kSeparatorLineHeight, kScreen_Width, kSeparatorLineHeight);
        bottomLine.backgroundColor = kSeparatorLineColor.CGColor;
        [self.layer addSublayer:bottomLine];
    }
    return _headLabel;
}

@end
